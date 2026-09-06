# app_ui

The design system behind [FlutterGuide](../../README.md): the tokens every
screen measures itself in, and the widgets built from nothing but those tokens
and Flutter itself.

It is a local package, wired into the app as a `path` dependency, and imported
through its single entry point:

```dart
import 'package:app_ui/app_ui.dart';
```

## The boundary

Nothing under `lib/src/` may import `flutter_guide/`, read a Riverpod provider,
or read `AppLocalizations`. A widget that needs any of the three is app code,
however generic it looks, and belongs in `lib/src/shared/` instead. The
reasoning, and the widgets that stayed behind because of it, are in
[docs/architecture.md](../../docs/architecture.md).

Text is a parameter here, never a literal: the app owns translation.

## Contents

| Directory | Holds |
| --- | --- |
| `lib/src/tokens/` | `AppColors`, `AppSpacing`, `AppRadius`, `AppDurations` |
| `lib/src/widgets/` | Buttons, dialogs, list tiles and the tab bar |

Anything added to either is exported from
[`lib/app_ui.dart`](lib/app_ui.dart); the app never imports a path under
`src/`.

## Checks

The package analyzes and tests on its own, under its own `analysis_options.yaml`
and a coverage gate of 98%:

```sh
cd packages/app_ui
fvm flutter test --coverage
../../scripts/check_coverage.sh coverage/lcov.info 98
```

[`scripts/verify.sh`](../../scripts/verify.sh) runs exactly that whenever a
change touches this package, and CI runs it as a job of its own.
