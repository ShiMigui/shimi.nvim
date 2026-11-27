#!/usr/bin/env python3
"""Version signal validation and automatic SemVer releases.

Usage: version.py check <pr-number> | version.py release <commit-sha>
"""
import json
import os
import re
import subprocess
import sys

VALID = {"version:major": 3, "version:minor": 2, "version:patch": 1}
OWNER, NAME = os.environ["REPO"].split("/", 1)
REPO = f"{OWNER}/{NAME}"

QUERY = """query($owner:String!, $repo:String!, $pr:Int!) {
  repository(owner:$owner, name:$repo) { pullRequest(number:$pr) {
    labels(first:100) { nodes { name } }
    closingIssuesReferences(first:100) {
      nodes { number labels(first:100) { nodes { name } } }
    }
  } } }"""


def run(args, check=True):
    p = subprocess.run(args, text=True, capture_output=True)
    if check and p.returncode:
        raise RuntimeError(p.stderr.strip() or p.stdout.strip())
    return p.stdout.strip()


def api(path, check=True):
    out = run(["gh", "api", path], check)
    return json.loads(out) if out else None


def bump_for(pr):
    args = ["gh", "api", "graphql", "-f", "query=" + QUERY,
            "-F", f"owner={OWNER}", "-F", f"repo={NAME}", "-F", f"pr={int(pr)}"]
    data = json.loads(run(args))["data"]["repository"]["pullRequest"]
    if not data:
        raise ValueError(f"Pull request #{pr} not found")
    pr_labels = [n["name"] for n in data["labels"]["nodes"]]
    issues = data["closingIssuesReferences"]["nodes"]
    issue_labels = [[n["name"] for n in i["labels"]["nodes"]] for i in issues]
    labels = pr_labels + [n for group in issue_labels for n in group]

    unknown = {n for n in labels if n.startswith("version:") and n not in VALID}
    if unknown:
        raise ValueError(f"Unknown version labels: {', '.join(sorted(unknown))}")
    majors = [i["number"] for i, group in zip(issues, issue_labels)
              if "version:major" in group]
    if len(majors) > 1:
        raise ValueError(f"A PR may close at most one version:major issue (found {majors})")
    signals = {n for n in labels if n in VALID}
    if not signals:
        raise ValueError("No version signal: close a labeled issue or label the PR")
    return max(signals, key=VALID.get)


def next_tag(bump):
    tags = api(f"repos/{REPO}/tags?per_page=100") or []
    versions = [tuple(map(int, m.groups())) for t in tags
                if (m := re.fullmatch(r"v?(\d+)\.(\d+)\.(\d+)", t["name"]))]
    ma, mi, pa = max(versions, default=(0, 0, 0))
    parts = [ma, mi, pa]
    index = {"version:major": 0, "version:minor": 1, "version:patch": 2}[bump]
    parts[index] += 1
    for i in range(index + 1, 3):
        parts[i] = 0
    return "v" + ".".join(map(str, parts))


def main():
    mode, arg = sys.argv[1], sys.argv[2]
    if mode == "check":
        try:
            bump = bump_for(arg)
        except (ValueError, RuntimeError) as e:
            print(f"::error::{e}")
            sys.exit(1)
        print(f"Effective bump: {bump}")
        with open(os.environ["GITHUB_OUTPUT"], "a") as fh:
            fh.write(f"bump={bump}\n")
    elif mode == "release":
        prs = [p for p in (api(f"repos/{REPO}/commits/{arg}/pulls") or [])
               if p.get("merged_at")]
        if not prs:
            raise RuntimeError(f"No merged pull request for commit {arg}")
        bump = bump_for(prs[0]["number"])
        tag = next_tag(bump)
        if api(f"repos/{REPO}/releases/tags/{tag}", check=False):
            print(f"Release {tag} already exists; nothing to do")
            return
        run(["gh", "release", "create", tag, "--target", arg,
             "--title", tag, "--generate-notes"])
        print(f"Created {tag} ({bump}) at {arg}")
    else:
        raise SystemExit(f"Unknown mode: {mode}")


if __name__ == "__main__":
    main()
