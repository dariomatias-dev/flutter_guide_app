# Working agreement

This file is the process for any change to this repository, whether it comes
from a person or an agent. It is not documentation of what the app does: that
lives in `README.md` and `CONTRIBUTING.md`.

## Commands

Every Flutter and Dart command runs through FVM. Bare `flutter` picks whatever
the machine happens to have installed, which is not the version `.fvmrc` pins
and not the version CI uses.

```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm flutter gen-l10n
./scripts/verify.sh              # the whole gate, what CI runs
./scripts/verify.sh --skip-tests # mid-change check, never the final one
```

## The loop for every change

1. Read the code around the change before writing any. This app has an
   established shape; match it rather than introducing a second one.
2. Make the change, including its tests and its localized strings.
3. Run `./scripts/verify.sh`. It has to pass before the change is finished.
4. Report what changed and hand over the suggested commit message. Stop there.

Nothing is committed without being asked in that turn. No `git add`, no
`git commit`, no `git push`, no branch or tag created on the agent's own
initiative. The commit is the maintainer's.

## Where code goes

| Kind of code | Directory |
| --- | --- |
| Cross-feature infrastructure: services, theme, router, shell, enums, extensions, constants | `lib/src/core/` |
| Providers that wire core dependencies (preferences, theme, navigation) | `lib/src/core/di/` |
| A feature's screens, widgets, view models and its providers | `lib/src/features/<feature>/presentation/` |
| A feature's repository contracts and entities | `lib/src/features/<feature>/domain/` |
| A feature's repository implementations, data sources and models | `lib/src/features/<feature>/data/` |
| Widgets and helpers used by more than one feature | `lib/src/shared/` |
| Catalog sample code shown to the user | `lib/src/features/catalog/data/samples/` |
| User-facing strings | `lib/l10n/app_en.arb`, plus `app_es.arb` and `app_pt.arb` |

The features are `catalog`, `code_theme_selector`, `home` and `settings`. A
new feature gets its own directory with the same three layers; it does not get
a layer it has no content for.

## The catalog samples are data, not app code

`lib/src/features/catalog/data/samples/` holds 226 sample files: the code the
app renders to the user as teaching material. They follow different rules from
everything else, deliberately:

- They keep literal values inline. A sample that reads `AppSpacing.md` teaches
  a token the reader cannot see the value of.
- They are excluded from the coverage gate. Their 6967 coverable lines drag
  the reported figure from 95% to 24% while saying nothing about the app.
- A sample is registered in `data/samples/sample_definitions/` and resolved by
  `presentation/samples/sample_registry.dart`. Adding a sample means adding it
  to a definition list, not wiring a new screen.

Do not "fix" a sample to match the app's conventions. If a sample is wrong as
teaching material, that is a reason to change it; consistency with the app is
not.

## State

Riverpod, with hand-written providers. A view model is a `Notifier` or
`AsyncNotifier` that reads its repository through a provider and exposes state
to the screen. Repositories are contracts in `domain/repositories/`,
implemented in `data/repositories/`, and reach the outside world through a
service in `lib/src/core/services/`.

## Tests

`test/` mirrors `lib/src/`, file for file. Test doubles are `mocktail` mocks,
and dependencies are replaced with `ProviderContainer` overrides rather than
by reaching into the widget tree.

| Change | Test it needs |
| --- | --- |
| View model, repository, service, helper | Unit test against a mock of its dependency, covering the failure path as well as the success one |
| Screen or widget | Widget test through `pumpApp`; use `pumpScopedApp` when the widget opens a dialog, popup menu or snack bar, since overlay routes attach above the `Scaffold` |
| Route, deep link | Test through the router helper in `test/helpers/pump_router_app.dart` |
| New ARB key | No test, but every language file gets the key and the template gets a description; `scripts/check_l10n.sh` fails otherwise |
| New catalog sample | None of its own. `sample_registry_test.dart` already resolves every registered component, so a sample missing from a definition list fails there |

## Ripple effects

| Touching this | Also update |
| --- | --- |
| An ARB key | All three language files, then `fvm flutter gen-l10n`, and commit the regenerated output |
| `pubspec.yaml` | `pubspec.lock`, via `fvm flutter pub get` |
| A script in `scripts/` | Its row in all three README tables, and `CONTRIBUTING.md` if the gate's behaviour changed |
| A CI job | `CONTRIBUTING.md`, which names the jobs and says which ones block a merge |
| A user-visible feature | `CHANGELOG.md` is written by release-please from the commits: no manual entry, but the commit type decides the version bump |
| Anything under `lib/` | The mirroring file under `test/` |

## Non-negotiables

- No hardcoded user-facing text outside the ARB files.
- No inline styling where the theme already carries the value.
- Comments explain why, never what the line already says.
- No new architectural pattern without agreeing on it first. A second way of
  doing something that already has a way is a defect, not an improvement.
- Documentation changes land in all three languages, or they are broken.
- Public API carries doc comments; `very_good_analysis` enforces it.
- Never commit without being asked.
