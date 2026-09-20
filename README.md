<br>
<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android">
</div>
<br>

<div align="center">
  <a href="https://github.com/dariomatias-dev/flutter_guide_app/actions/workflows/ci.yaml">
    <img src="https://github.com/dariomatias-dev/flutter_guide_app/actions/workflows/ci.yaml/badge.svg" alt="CI">
  </a>
  <a href="https://codecov.io/gh/dariomatias-dev/flutter_guide_app">
    <img src="https://codecov.io/gh/dariomatias-dev/flutter_guide_app/branch/main/graph/badge.svg" alt="Coverage">
  </a>
  <img src="https://img.shields.io/badge/lints-very__good__analysis-blueviolet?style=flat" alt="very_good_analysis">
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-green.svg" alt="MIT License">
  </a>
</div>
<br>

<p align="center">
  <strong>English</strong> · <a href="README.es.md">Español</a> · <a href="README.pt-BR.md">Português (BR)</a>
</p>

<h1 align="center">FlutterGuide</h1>

<p align="center">
  An Android app for browsing Flutter/Dart widgets, functions, and packages, each with runnable code and a live preview.
  <br>
  <a href="#about-the-project"><strong>Explore the docs »</strong></a>
  <br>
  <br>
  <a href="https://github.com/dariomatias-dev/flutter_guide_app/issues">Report Bug</a>
  ·
  <a href="https://github.com/dariomatias-dev/flutter_guide_app/issues">Request Feature</a>
</p>

## Table of Contents

- [About the Project](#about-the-project)
- [Preview](#preview)
- [Features](#features)
- [The Catalog](#the-catalog)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Scripts](#scripts)
- [Testing](#testing)
- [Deployment](#deployment)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)
- [Author](#author)

## About the Project

**FlutterGuide** is a mobile catalog of Flutter and Dart building blocks for developers who learn by example. Each entry (widget, function or package) ships with its source code and a live, interactive preview rendered inside the app, so the behavior can be seen before it is copied into another project.

The app is published on [Google Play](https://play.google.com/store/apps/details?id=com.dariomatias.flutter_guide), and the website is at [flutterguide.app](https://flutterguide.app).

## Preview

<div align="center">
  <img src="screenshots/en/01_home.png" width="200" alt="Home">
  <img src="screenshots/en/05_component_detail.png" width="200" alt="Component preview">
  <img src="screenshots/en/06_component_code.png" width="200" alt="Component code">
  <br>
  <sub>The home screen, a component preview and its source code.</sub>
</div>

## Features

- **Live previews with source code**: every widget, function and package shows its runnable code next to an interactive preview and a link to the official documentation.
- **Elements and UI samples**: complete sample screens (login, chat, email client and others) and reusable interface elements to study or copy.
- **Deep linking**: open a specific component or sample from a shared link.
- **Code theme selector**: choose the syntax highlighting theme of the code samples, with light and dark variants.
- **Favorites**: save any widget, function or package for later.
- **Search**: filter each catalog by name as you type.
- **Languages**: English, Portuguese (Brazil) and Spanish.
- **Light and dark theme**, with the choice persisted.
- **Accessibility**: semantic labels on interactive elements for screen readers.

## The Catalog

Widgets are Material and Cupertino, functions are core Dart functions, and packages are third-party libraries, among them `dio`, `http`, `cached_network_image`, `flutter_svg`, `video_player`, `flutter_animate`, `photo_view` and `shimmer`. Elements are reusable interface pieces and UI samples are complete screens.

| Category   | Count   |
| ---------- | ------- |
| Widgets    | 142     |
| Packages   | 46      |
| Functions  | 13      |
| Elements   | 9       |
| UI samples | 5       |
| **Total**  | **215** |

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/)
- **State and dependency injection**: [Riverpod](https://riverpod.dev/)
- **Routing and deep links**: [go_router](https://pub.dev/packages/go_router) and [app_links](https://pub.dev/packages/app_links)
- **Persistence**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Localization**: [intl](https://pub.dev/packages/intl) and Flutter's built-in `l10n` tooling
- **Code samples**: [flutter_syntax_highlighter](https://pub.dev/packages/flutter_syntax_highlighter)
- **Monetization**: [google_mobile_ads](https://pub.dev/packages/google_mobile_ads)
- **Quality**: [mocktail](https://pub.dev/packages/mocktail), [very_good_analysis](https://pub.dev/packages/very_good_analysis) and [FVM](https://fvm.app/) to pin the SDK

## Architecture

The app is organized by feature (`lib/src/features/`: `catalog`, `home`, `settings` and `code_theme_selector`), each split into `data`, `domain` and `presentation`, with Riverpod for state and go_router for routing. Cross-cutting code lives in `lib/src/core`, and the design system in `packages/app_ui`, a separate package whose `pubspec.yaml` does not depend on the app, so the compiler rejects any import back into it.

The layering rules, the subsystems and the decisions behind them are in [docs/architecture.md](docs/architecture.md).

## Getting Started

Requirements: [FVM](https://fvm.app/), which pins the Flutter SDK version the project uses, Git, and an Android device or emulator. Every command below uses `fvm flutter` rather than a bare `flutter`.

The `.env` file is git-ignored; leave the values empty to run without ads.

```sh
git clone https://github.com/dariomatias-dev/flutter_guide_app.git
cd flutter_guide_app
fvm install
fvm flutter pub get
cat > .env <<'EOF'
DEVICE_ID=
BANNER_AD_ID=
BANNER_AD_SAMPLE_ID=
INTERSTICIAL_AD_SAMPLE_ID=
REWARDED_AD_SAMPLE_ID=
APP_OPEN_AD_SAMPLE_ID=
EOF
fvm flutter run
```

## Scripts

Helper scripts live under `scripts/`, in the order of use: development first, then quality.

| Command                                           | Description                                                                                                                                                                                                                                       |
| ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `scripts/screenshot.sh [device-id]`               | Drives the app through its main screens on a connected device, in all three locales, saving the captures under `screenshots/<locale>/`. Run `fvm flutter devices` to list device ids.                                                             |
| `scripts/verify.sh [--all] [--skip-tests]`        | Runs what CI runs: regenerates code and localizations (failing if the committed output was stale), then ARB parity, format, analyze, tests and coverage. `--all` checks everything; `--skip-tests` is for mid-change checks, never the final one. |
| `scripts/check_l10n.sh [arb-dir]`                 | Fails when the ARB files disagree on their keys or a template key has no description. `gen-l10n` falls back to the template silently, so nothing else catches it.                                                                                 |
| `scripts/check_coverage.sh <lcov-file> <minimum>` | Fails when line coverage is below the minimum, excluding generated sources and the catalog samples, which are teaching material, not app logic.                                                                                                   |

## Testing

Unit and widget tests live under `test/`, mirroring `lib/src/`, and use `mocktail` with `ProviderContainer` overrides. `packages/app_ui` tests itself, and one integration test drives the app on a device to capture the screenshots.

```sh
fvm flutter test                                                       # the app
(cd packages/app_ui && fvm flutter test)                               # the design system
fvm flutter test integration_test/screenshot_test.dart -d <device-id>  # screenshots, on a connected device
./scripts/verify.sh                                                    # the same gate CI runs
```

The gate fails on stale generated code or localizations, mismatched ARB files, formatting, analyzer warnings, failing tests and coverage below the threshold. See [docs/contributing.md](docs/contributing.md) for the thresholds and for which CI job blocks a merge.

## Deployment

FlutterGuide runs on Android and is published on Google Play. Every pull request and every push to `main` runs the CI pipeline, and each job blocks the merge (the quality gate for the app and for `packages/app_ui`, the dependency vulnerability scan, the release APK build and the emulator run of the integration test), except the coverage upload, which only reports.

Releases are cut by release-please: it reads the Conventional Commits landed on `main`, keeps a pull request open with the next version and the `CHANGELOG.md` entry, and on merge tags the commit and attaches the signed APK and app bundle to the GitHub release. Uploading the bundle to Google Play is manual. The details are in [docs/contributing.md](docs/contributing.md).

## Documentation

| Document                                   | What it covers                                                               |
| ------------------------------------------ | ---------------------------------------------------------------------------- |
| [Architecture](docs/architecture.md)       | Layout, layering rules, and the decision behind each subsystem               |
| [Contributing](docs/contributing.md)       | Setup, the local gate, what CI checks, releases, and the commit convention   |
| [Security policy](docs/security.md)        | How to report a vulnerability privately, and what is in scope                |
| [Code of Conduct](docs/code_of_conduct.md) | Behaviour expected in project spaces                                         |
| [Working agreement](CLAUDE.md)             | The process every change follows, whether it comes from a person or an agent |
| [Design system](packages/app_ui/README.md) | What `packages/app_ui` holds, and the boundary that keeps it app-agnostic    |

## Contributing

Contributions are welcome. Before opening a pull request, run the local gate, which runs the same checks as CI:

```sh
./scripts/verify.sh
```

See [docs/contributing.md](docs/contributing.md) for the setup, the commit convention and the branching rules. Participation is covered by the [Code of Conduct](docs/code_of_conduct.md).

## Security

Found a vulnerability? Do not open a public issue: follow the [security policy](docs/security.md).

## License

Distributed under the **MIT License**. See the [LICENSE](LICENSE) file for more information.

## Author

Developed by **Dário Matias Sales**:

- **Portfolio**: [dariomatias-dev](https://dariomatias-dev.com)
- **GitHub**: [dariomatias-dev](https://github.com/dariomatias-dev)
- **Email**: [dariomatias.dev@gmail.com](mailto:dariomatias.dev@gmail.com)
- **Instagram**: [@dariomatias_dev](https://instagram.com/dariomatias_dev)
- **LinkedIn**: [linkedin.com/in/dariomatias-dev](https://linkedin.com/in/dariomatias-dev)
