# Contributing

## Setup

After cloning, enable the repo's git hooks:

```bash
git config core.hooksPath .githooks
```

This activates a `commit-msg` hook that rejects commits not following the
convention below.

## Commit convention

This project follows [Conventional Commits](https://www.conventionalcommits.org):

```
<type>(<scope>): <subject>
```

- **type**: `feat`, `fix`, `refactor`, `docs`, `style`, `test`, `chore`, `perf`, `build`, `ci`, `revert`
- **scope**: optional, lowercase, e.g. `catalog`, `theme`
- **subject**: imperative mood, no trailing period, ≤72 chars

Examples:

```
feat(catalog): add Table widget sample
fix(theme): rebuild widgets on theme state changes
refactor(catalog): centralize ComponentSampleArgs construction
```

Body (optional) explains *why*, not *what* — the diff already shows what
changed.

## Branching

- `main` is protected: no direct pushes, merges only via pull request.
- Branch names: `<type>/<short-description>` (e.g. `feat/table-sample`,
  `fix/dropdown-alignment`).

## Pull requests

- One logical change per PR; keep it small and reviewable.
- CI (`analyze-and-test`) must pass before merge.
- Squash or rebase merge only — no merge commits, to keep history linear
  and each entry a valid Conventional Commit.
- For this repo (single maintainer), self-merge after CI passes is allowed;
  branch protection still requires the PR flow and passing checks.

## Code style

- Follows `very_good_analysis` lints — run `flutter analyze` before pushing.
- Run `dart format .` before committing.
