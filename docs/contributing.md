# Contributing

<p align="center">
<strong>English</strong> · <a href="contributing.es.md">Español</a> · <a href="contributing.pt-BR.md">Português (BR)</a>
</p>

Thanks for considering a contribution. This document covers setup, the checks
a change has to pass, and the conventions a pull request is reviewed against.

## Setup

The project pins its Flutter SDK version with [FVM](https://fvm.app/), so every
command below uses `fvm flutter` rather than a bare `flutter` install. A bare
`flutter` picks whatever the machine has, which is not what CI uses.

```bash
git clone https://github.com/dariomatias-dev/flutter_guide_app.git
cd flutter_guide_app
fvm install
fvm flutter pub get
git config core.hooksPath .githooks
```

The last line enables the `commit-msg` hook, which enforces the commit
convention below.

The app reads its ad unit ids from a `.env` file at the repository root, which
is not committed. The keys only have to exist for the app to build and run:

```bash
cat <<'EOF' > .env
DEVICE_ID=
BANNER_AD_ID=
BANNER_AD_SAMPLE_ID=
INTERSTICIAL_AD_SAMPLE_ID=
REWARDED_AD_SAMPLE_ID=
APP_OPEN_AD_SAMPLE_ID=
EOF
```

## Before opening a pull request

- [ ] `./scripts/verify.sh` passes
- [ ] New logic has tests, failure paths included; a bug fix has a test that fails without it
- [ ] `test/` still mirrors `lib/src/`
- [ ] New user-facing strings are in all three ARB files, with a description in `lib/l10n/app_en.arb`
- [ ] `fvm flutter gen-l10n` re-run and its output committed, if an ARB file changed
- [ ] `dart run build_runner build` re-run and its output committed, if a route in `core/navigation/navigators/` changed
- [ ] Documentation changed in all three languages, if it changed at all
- [ ] Commits follow the convention below

The structural rules a change is reviewed against live in
[`CLAUDE.md`](../CLAUDE.md): where each kind of code goes, what the catalog
samples do differently, and what counts as a ripple effect. They are not
repeated here, so they cannot drift.

## The local gate

```bash
./scripts/verify.sh
```

It runs exactly what CI runs, in the same order, for the app and for
`packages/app_ui` independently:

| Step | What it catches |
| --- | --- |
| `build_runner` and `gen-l10n`, and a diff of their output | Committed generated routes or localizations that no longer match their source. CI regenerates from a clean checkout and fails on any difference. App only: `packages/app_ui` has no generator |
| [`check_l10n.sh`](../scripts/check_l10n.sh) | A key missing from one language, or a template key with no description. `gen-l10n` falls back to English in silence |
| `dart format --set-exit-if-changed` | Formatting, the one check with a single correct answer |
| `flutter analyze` | `very_good_analysis` lints |
| `flutter test --coverage` | The test suite |
| [`check_coverage.sh`](../scripts/check_coverage.sh) | Line coverage under 95% for the app, 98% for `packages/app_ui`, excluding generated sources and the catalog samples |

Scope is derived from what changed: only the app, only `packages/app_ui`, or
both, depending on which paths have pending changes. The gate is skipped
entirely when nothing under `lib`, `test`, `integration_test`, `test_driver`,
`packages` or the manifests has changed. Pass `--all` to check everything
regardless, and `--skip-tests` for a quick mid-change check, never as the
final gate.

A passing run records the workspace hash in `.dart_tool/verify_stamp`, so
tooling can tell whether the tree still matches a run that passed.

## What CI checks

| Job | What it does | Merge |
| --- | --- | --- |
| `Vulnerabilities` | Runs `osv-scanner` against `pubspec.lock` and `packages/app_ui/pubspec.lock`, which are what actually ships, rather than the caret ranges in `pubspec.yaml`. Independent of the other jobs: a newly disclosed advisory is not a reason to stop the tests from reporting | Blocks |
| `packages/app_ui` | Formatting, analysis, tests and the 98% coverage gate for the design-system package, independently of the app, uploaded to Codecov under the `app_ui` flag | Blocks |
| `flutter_guide` | The gate above, step for step | Blocks |
| `Build APK` | Runs after `flutter_guide` passes and builds a release APK, uploaded as a workflow artifact kept for 14 days. Without a keystore in the checkout it falls back to the debug keys | Blocks |
| `Integration tests` | Runs after `flutter_guide` passes, boots an Android emulator and runs `integration_test/screenshot_test.dart` on it. The only check that runs the real app: real dotenv, real `SharedPreferences`, a real Android system, none of it faked the way a widget test fakes it. Enables KVM first, without which the emulator falls back to software rendering and times out | Blocks |
| Codecov upload | Reports the coverage delta on the pull request with inline annotations | Reports only |

The SDK version comes from `.fvmrc`, read with `jq` at the start of each job,
rather than repeated in the workflow. That is a deliberate divergence from the
common `env: FLUTTER_VERSION` pattern: two copies of a version drift, and the
pipeline then keeps building on a version nobody runs.

### Coverage reports

[`check_coverage.sh`](../scripts/check_coverage.sh) is what fails a build;
Codecov is what makes the number readable. Each package uploads its own
`lcov.info` under its own flag, so the app's 95% threshold and
`packages/app_ui`'s 98% are tracked separately, and a pull request gets a
comment with the per-flag delta and inline annotations on uncovered new
lines. `codecov.yml` holds the targets and repeats the script's exclusions:
generated sources, `lib/l10n/`, and the catalog samples under
`lib/src/features/catalog/data/samples/`. Those samples are teaching code
the app renders to the user, and their 6967 lines drag the reported figure
from 95% to 24% while saying nothing about the app itself.

Uploads authenticate with a `CODECOV_TOKEN` repository secret. A pull request
from a fork cannot read it, so the step is set to `fail_ci_if_error: false`: a
failed upload is a missing report, never a failed build.

### Releases

Releases are cut by [release-please](https://github.com/googleapis/release-please).
It reads the Conventional Commits landed on `main` and keeps a pull request
open carrying the next version and the `CHANGELOG.md` entry derived from them:
`fix:` bumps the patch, `feat:` the minor, and `!` before the colon the major.
Merging that pull request writes the version into `pubspec.yaml`, tags the
commit and publishes the GitHub release.

`release.yml` then runs the same gate as CI, builds the APK and the app bundle,
and attaches both. It is called directly by `release_please.yml`, since GitHub
does not start a workflow from a tag pushed with the default token, and it
still answers a `v*.*.*` tag pushed by hand.

The release build is signed with the upload key, assembled from repository
secrets and deleted from the runner afterwards. The job fails rather than
falling back to the debug keys, since a debug-signed artifact can neither be
uploaded to the Play Store nor installed over the store build. Publishing to
the Play Store stays manual: download the `.aab` from the release and upload it
there.

| Secret | Used for |
| --- | --- |
| `ANDROID_KEYSTORE_BASE64` | The upload keystore, base64 encoded: `base64 -w0 upload-keystore.jks` |
| `ANDROID_KEYSTORE_PASSWORD` | Its store password |
| `ANDROID_KEY_ALIAS` | The key alias inside the keystore |
| `ANDROID_KEY_PASSWORD` | The key password |
| `BANNER_AD_ID`, `BANNER_AD_SAMPLE_ID`, `INTERSTICIAL_AD_SAMPLE_ID`, `REWARDED_AD_SAMPLE_ID`, `APP_OPEN_AD_SAMPLE_ID` | The ad unit ids written into `.env` for the release build |
| `CODECOV_TOKEN` | The coverage upload in CI |

### Running the workflows locally

[`act`](https://github.com/nektos/act) runs the workflows in Docker, which is
worth doing before pushing a change to anything under `.github/workflows/`.
`.actrc` already pins the runner image, so no flags are needed:

```bash
act -l                            # list every job, with its id and stage
act pull_request                  # everything CI would run on a pull request
act pull_request -j app           # one job, by its id
act pull_request -j app --dryrun  # print the steps without running them
```

`-j` takes the job id (`vulnerabilities`, `app_ui`, `app`, `build_apk`,
`integration`),
not the display name; `act -l` prints both. The first run pulls a
multi-gigabyte image, and `act` approximates GitHub's runners rather than
reproducing them, so a green run here is a signal, not a guarantee:
`secrets.CODECOV_TOKEN` is empty locally, the OSV scanner needs network
access to the advisory database, and `act` cannot run the `integration`
job's emulator action at all.

## Working with an AI agent

The repository carries its own agent configuration, so an assistant follows the
same process a contributor does instead of improvising one per prompt:

- [`CLAUDE.md`](../CLAUDE.md) is the working agreement: the loop for every
  change, where each kind of code goes, what the catalog samples do
  differently, and what is non-negotiable.
- `.claude/hooks/format-dart.sh` formats a Dart file right after it is written.
- `.claude/hooks/verify-gate.sh` refuses to end a turn that leaves code the
  gate has not passed against.

Changing the agreement is a normal change, reviewed like any other.

## Dependency updates

[Renovate](https://docs.renovatebot.com) opens the update pull requests weekly,
prefixed `build(deps):` so they pass the message hook and feed release-please.
`renovate.json` holds the rules, and the dependency dashboard issue lists
everything it is holding back.

Renovate rather than Dependabot because only Renovate can disable or group
updates by package name. Two rules exist today: `intl` is dictated by the
`flutter_localizations` that ships with the pinned SDK, so it moves with the
SDK; and `go_router` moves together with its route generator, since a skew
between them fails code generation rather than analysis. Never run both bots.

An update pull request is triaged like any other change: the gate has to pass,
and a bump that changes behaviour needs the behaviour checked, not just a green
pipeline.

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

The body is optional and exists for the *why*. The diff already shows what
changed.

## Branching

- `main` is protected: no direct pushes, merges only via pull request.
- Branch names: `<type>/<short-description>`, e.g. `feat/table-sample`,
  `fix/dropdown-alignment`.

## Pull requests

- One logical change per pull request; keep it small and reviewable.
- Squash or rebase merge only, no merge commits, so history stays linear and
  every entry is a valid Conventional Commit.
- For this repository (single maintainer), self-merge after CI passes is
  allowed; branch protection still requires the pull request flow and passing
  checks.

## Code of Conduct

Participation in this project is covered by the
[Code of Conduct](code_of_conduct.md). Security reports follow the
[security policy](security.md), never a public issue.
