#!/usr/bin/env python3
"""Validate the version signal of a pull request.

Every change produces a new version, including dependency updates. A PR is
valid when it either closes at least one issue carrying a ``version:*``
label, or carries an explicit ``version:*`` label on the PR itself.

Bump precedence: version:major > version:minor > version:patch.
A PR may close at most one ``version:major`` issue, so a release never skips
a major version.
"""

import json
import os
import re
import subprocess
import sys

PRECEDENCE = {"version:patch": 1, "version:minor": 2, "version:major": 3}

# Closing keywords supported by GitHub, plus an optional "issue" word and a
# comma/"and"-separated list of references.
CLOSERS = re.compile(
    r"\b(?:close[sd]?|fix(?:e[sd])?|resolve[sd]?)\b\s*:?\s*(?:issues?\s*)?"
    r"((?:(?:[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+)?#\d+"
    r"(?:\s*(?:,|and|&|/)\s*(?:[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+)?#\d+)*))",
    re.IGNORECASE,
)
REF = re.compile(r"(?:([A-Za-z0-9_.-]+)/([A-Za-z0-9_.-]+))?#(\d+)", re.IGNORECASE)


def fail(message):
    print(f"::error::{message}")
    print(f"\nFAIL: {message}")
    sys.exit(1)


def gh_api(path):
    result = subprocess.run(
        ["gh", "api", path], text=True, capture_output=True, check=False
    )
    if result.returncode != 0:
        return None
    try:
        return json.loads(result.stdout)
    except json.JSONDecodeError:
        return None


def closed_issue_numbers(text, repo):
    """Issue numbers referenced by closing keywords in ``text``."""
    owner, name = repo.split("/", 1)
    numbers = set()
    for match in CLOSERS.finditer(text or ""):
        for ref in REF.finditer(match.group(1)):
            ref_owner, ref_repo, number = ref.groups()
            if ref_owner is None or (ref_owner.lower(), ref_repo.lower()) == (
                owner.lower(),
                name.lower(),
            ):
                numbers.add(int(number))
    return numbers


def split_version_labels(names):
    valid = {n for n in names if n in PRECEDENCE}
    unknown = {
        n for n in names if n.startswith("version:") and n not in PRECEDENCE
    }
    return valid, unknown


def main():
    repo = os.environ.get("REPO", "")
    pr_number = os.environ.get("PR_NUMBER", "")
    if not repo or not repo.count("/") == 1 or not pr_number.isdigit():
        fail("REPO and numeric PR_NUMBER must be provided by the workflow.")

    pull = gh_api(f"repos/{repo}/pulls/{pr_number}")
    if pull is None:
        fail(f"Could not fetch pull request #{pr_number}.")

    pr_labels = [label["name"] for label in pull.get("labels", [])]
    text = f"{pull.get('title') or ''}\n{pull.get('body') or ''}"
    numbers = closed_issue_numbers(text, repo)

    pr_versions, pr_unknown = split_version_labels(pr_labels)
    issue_versions = {}
    unknown = set(pr_unknown)
    ignored = []
    for number in sorted(numbers):
        issue = gh_api(f"repos/{repo}/issues/{number}")
        if issue is None:
            ignored.append(f"#{number} (not found)")
            continue
        if "pull_request" in issue:
            ignored.append(f"#{number} (pull request, not an issue)")
            continue
        labels = [label["name"] for label in issue.get("labels", [])]
        found, bad = split_version_labels(labels)
        issue_versions[number] = found
        unknown |= bad

    print(f"PR labels: {', '.join(sorted(pr_labels)) or '(none)'}")
    print(f"Closed issues referenced: {', '.join(f'#{n}' for n in sorted(numbers)) or '(none)'}")
    for number, labels in sorted(issue_versions.items()):
        print(f"  #{number}: {', '.join(sorted(labels)) or '(no version label)'}")

    if unknown:
        fail(f"Unknown version labels: {', '.join(sorted(unknown))}.")

    major_issues = sorted(
        n for n, labels in issue_versions.items() if "version:major" in labels
    )
    if len(major_issues) > 1:
        fail(
            "A pull request may close at most one version:major issue "
            f"(found: {', '.join(f'#{n}' for n in major_issues)}); "
            "releasing two majors at once would skip a version."
        )

    signals = set(pr_versions)
    for labels in issue_versions.values():
        signals |= labels
    if not signals:
        fail(
            "No version signal found. The PR must either close an issue with a "
            "version:major/minor/patch label, or carry an explicit version label "
            "on the PR itself (for example, dependency updates)."
        )

    bump = max(signals, key=lambda label: PRECEDENCE[label])
    details = [
        f"PR: {', '.join(sorted(pr_versions)) or 'none'}",
        "Issues: "
        + (
            ", ".join(
                f"#{n} -> {', '.join(sorted(labels)) or 'none'}"
                for n, labels in sorted(issue_versions.items())
            )
            or "none"
        ),
    ]
    if ignored:
        details.append("Ignored: " + ", ".join(ignored))
    print(f"Effective bump: {bump} (precedence: major > minor > patch)")

    output = os.environ.get("GITHUB_OUTPUT")
    if output:
        with open(output, "a", encoding="utf-8") as fh:
            fh.write(f"bump={bump}\n")
            fh.write(f"version-label={bump}\n")
    summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary:
        with open(summary, "a", encoding="utf-8") as fh:
            fh.write("## PR version check\n\n")
            fh.write(f"Effective bump: `{bump}`\n\n")
            for line in details:
                fh.write(f"- {line}\n")
    sys.exit(0)


if __name__ == "__main__":
    main()
