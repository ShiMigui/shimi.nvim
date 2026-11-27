# Contributing

Thanks for helping improve shimi.nvim. This is a personal Neovim configuration
with a deliberately small scope. Read this document, the README, and the
relevant issues before opening a pull request.

## Ground rules

- Everything in this project is **100% English**: documentation, code comments,
  commit messages, issue text, pull request titles and bodies, and review
  discussion.
- **Study the codebase before submitting changes.** Read the existing modules,
  the README, and the issues involved. Do not propose changes based on
  assumptions about how the configuration behaves.
- **Implement one or more issues at a time.** A change should be tied to an
  issue, or carry its own version label when no issue applies (see
  [Version labels](#version-labels)).
- **Stay inside the issue.** Implement what the issue asks and nothing else.
  Do not add extra refactors, plugins, helpers, or files that the issue does
  not require.
- **Multiple issues must be visible in the diff.** If one pull request handles
  several issues, the description must state, per issue, where and how it was
  implemented: the issue number, the files and functions touched, and the
  resulting behavior. Each issue must remain independently identifiable.

## Branches and pull requests

- `main` is protected: no direct pushes, no force pushes, no branch deletion,
  and no admin bypass. Every change lands through a pull request.
- Branch from `main`, keep commits small and focused, and open the pull request
  against `main`.
- The `version-check` check is required and must pass before merge. Do not
  bypass it.
- Write the pull request description in English. Explain what changed and why.
  Use a closing keyword (`Closes #123`) when the pull request implements an
  issue, so the version signal is picked up automatically.

## Version labels

Every change produces a new version. There is no label or flag that suppresses
a release, including for dependency updates and routine maintenance.

- When a pull request closes issues carrying `version:major`, `version:minor`,
  or `version:patch`, those labels determine the bump.
- If several version labels are present, the highest precedence wins:
  `version:major` > `version:minor` > `version:patch`.
- A pull request may close at most one `version:major` issue, so a release
  never skips a major version.
- **If a pull request does not close an issue** — dependency updates and
  routine/chore work in particular — **it must carry an explicit `version:`
  label on the pull request itself, usually `version:patch`.**
- Unknown `version:*` labels, and pull requests with no version signal at all,
  fail the required check.

## Formatting and verification

- Lua is formatted with StyLua using `.stylua.toml`. Run
  `stylua --check lua init.lua` before opening a pull request.
- Make sure the Lua configuration still loads and has no syntax errors.
- Confirm that `version-check` is green on the pull request.

## Do not

- Do not commit, stage, or push `ISSUES.md`. It is a local planning document.
- Do not create tags or releases by hand.
- Do not add unrelated changes "while you are there".
- Do not write any project text in a language other than English.
