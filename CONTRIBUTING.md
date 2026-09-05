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

<optional body, explaining why>
```

The `commit-msg` hook enforces every rule below.

- **type**: `feat`, `fix`, `refactor`, `docs`, `style`, `test`, `chore`, `perf`, `build`, `ci`, `revert`
- **scope**: optional, lowercase, in parentheses, e.g. `catalog`, `theme`
- **breaking change**: `!` before the colon, e.g. `refactor(nav)!: drop the untyped router`
- **subject**: imperative mood, starting lowercase, no trailing period
- **subject line**: at most 72 characters, type and scope included
- **blank line** between the subject and the body
- **body**: wrapped at 80 columns, except URLs, git trailers such as
  `Co-Authored-By:` or `Refs #123`, and fenced code blocks

Examples:

```
feat(catalog): add Table widget sample
fix(theme): rebuild widgets on theme state changes
refactor(catalog): centralize ComponentSampleArgs construction
```

Body (optional) explains *why*, not *what*: the diff already shows what
changed.

## Local gate

Run the gate before opening a pull request:

```bash
./scripts/verify.sh
```

It runs exactly what CI runs, in the same order:

| Step | What it catches |
| --- | --- |
| `gen-l10n` and a diff of its output | Committed localizations that no longer match the ARB files. CI regenerates from a clean checkout and fails on any difference |
| `scripts/check_l10n.sh` | A key missing from one language, or a template key with no description. `gen-l10n` falls back to English in silence |
| `dart format --set-exit-if-changed` | Formatting, the one check with a single correct answer |
| `flutter analyze` | `very_good_analysis` lints |
| `flutter test --coverage` | The test suite |
| `scripts/check_coverage.sh` | Line coverage under 90%, excluding generated sources and the catalog samples |

The gate is skipped when nothing under `lib`, `test`, `integration_test`,
`test_driver` or the manifests has changed. Pass `--all` to run it anyway, and
`--skip-tests` for a quick mid-change check, never as the final gate.

A passing run records the workspace hash in `.dart_tool/verify_stamp`, so
tooling can tell whether the tree still matches a run that passed.

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

- Follows `very_good_analysis` lints, enforced by the gate above.
- Every Flutter command runs through FVM: `fvm flutter`, never bare `flutter`.
  The version lives in `.fvmrc`.
