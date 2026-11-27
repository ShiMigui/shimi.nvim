# AGENTS.md

Instructions for coding agents working in this repository. Human contributors
should read `CONTRIBUTING.md` as well.

## Language

All output is **100% English**. Write documentation, code comments, commit
messages, pull request titles and bodies, and final reports in English only.

## Before changing anything

- **Study the codebase first.** Read `README.md`, `init.lua`, the relevant
  files under `lua/`, and the issues involved before editing anything.
- Read `ISSUES.md` for planning, but treat it as a local document: never
  stage, commit, or push it.
- Check git status, the current branch, and existing issues and pull requests.
  Do not create duplicates of work that already exists.

## Scope and issue handling

- Implement one or more issues at a time, and only those issues.
- Do not add extra files, abstractions, plugins, helpers, refactors, or
  documentation that the accepted issue does not call for. Prefer the smallest
  correct change that satisfies the acceptance criteria.
- When more than one issue is implemented, state explicitly in the pull
  request body **where and how each issue was implemented**: issue number,
  files and functions changed, and resulting behavior.
- Do not implement follow-up ideas, optional improvements, or unrelated fixes
  along the way.

## Versioning and pull requests

- `main` is protected: pull requests only, required `version-check` check,
  strict updates, no admin bypass, no force pushes, and no deletions.
- Never push directly to `main`. Create a branch, commit, push, and open a pull
  request against `main`.
- Every change produces a version bump. There is no skip-version path.
- When a pull request closes issues labeled `version:major`, `version:minor`,
  or `version:patch`, the bump follows precedence: major > minor > patch. A
  pull request may close at most one `version:major` issue.
- **When a pull request closes no issue** — dependency updates and routine or
  chore work in particular — **it must carry an explicit `version:` label,
  usually `version:patch`.**
- Do not create tags or releases manually.

## Formatting and verification

- Format Lua with StyLua using `.stylua.toml`:
  `stylua --check lua init.lua`.
- Verify that `version-check` passes on the pull request before reporting
  completion.
- Report exactly what changed, which issues were addressed (if any), and which
  version label was used.

## Deliverables

- Keep `ISSUES.md` local and untracked. Never include it in a commit or a pull
  request.
