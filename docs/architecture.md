# Architecture

<p align="center">
<strong>English</strong> · <a href="architecture.es.md">Español</a> · <a href="architecture.pt-BR.md">Português (BR)</a>
</p>

How the code is organized and why. For what the app is, see the
[README](../README.md); for how to set up and submit a change, see
[contributing.md](contributing.md).

## Layout

```text
lib/
├── main.dart                  Startup: dotenv, ads, preferences, ProviderScope
├── l10n/                      ARB files and the gen-l10n output
└── src/
    ├── flutter_guide_app.dart Root widget: theme, locale, router
    ├── core/                  Anything more than one feature depends on
    │   ├── constants/         Language codes, external links
    │   ├── di/                Providers for cross-feature dependencies
    │   ├── enums/             Component, interface and theme types
    │   ├── extensions/        Extensions on Dart and Flutter types
    │   ├── helpers/           Deep link parsing and handling
    │   ├── models/            Models shared across features
    │   ├── navigation/        Bottom bar index notifier
    │   ├── router/            go_router configuration, names and paths
    │   ├── services/          Wrappers over platform SDKs
    │   ├── shell/             Root scaffold: app bar and bottom bar
    │   └── theme/             ThemeData and the theme notifier
    ├── features/              One directory per feature, three layers each
    │   ├── catalog/           The component catalog and the samples
    │   ├── code_theme_selector/
    │   ├── home/
    │   └── settings/
    └── shared/                Widgets and utilities used by several features
```

Each feature holds the same three layers, and only the ones it has content
for:

```text
features/<feature>/
├── data/          Repository implementations, data sources, models
├── domain/        Repository contracts and entities
└── presentation/  Screens, widgets, view models, providers
```

## Layering

The dependency direction is one way: `presentation` depends on `domain`,
`data` implements `domain`, and `domain` depends on neither. A screen never
reaches a data source directly; it reads a view model, which holds a
repository contract, which is implemented in `data` and reaches the outside
world through a service in [`core/services/`](../lib/src/core/services).

`core/` is for what more than one feature needs. A file used by exactly one
feature belongs to that feature, even when it looks generic. `shared/` holds
widgets and helpers with no feature of their own, such as
[`card_widget`](../lib/src/shared/widgets/card_widget) and
[`open_url`](../lib/src/shared/utils/open_url).

`Widget` never crosses into `domain` or `data`. That is why sample resolution
lives in the presentation layer, in
[`sample_registry.dart`](../lib/src/features/catalog/presentation/samples/sample_registry.dart),
even though the sample lists it reads are data.

## State management

Riverpod, with hand-written providers rather than generated ones. A screen
watches a view model; a view model is a `Notifier` or `AsyncNotifier` that
reads its repository through a provider and exposes state.

Providers are grouped by what they wire, not by type:

- [`core/di/`](../lib/src/core/di) holds the cross-feature ones: preferences,
  theme, bottom bar index, and whether ads are enabled.
- `features/<feature>/presentation/providers/` holds a feature's own.

[`sharedPreferencesProvider`](../lib/src/core/di/shared_preferences_provider.dart)
is declared without a value and overridden in `main.dart` with the instance
that startup already awaited. That keeps the rest of the graph synchronous:
nothing downstream has to be a `FutureProvider` just because storage was
opened asynchronously, and a test overrides the same provider with a mock
instance.

[`adsEnabledProvider`](../lib/src/core/di/ads_enabled_provider.dart) exists so
the screenshot run can override it to `false`. Marketing images should not
carry an ad banner, and an override is cheaper than a build flag.

## Navigation

[`go_router`](../lib/src/core/router/app_router.dart), with the paths and names
kept apart from the configuration in
[`route_paths.dart`](../lib/src/core/router/route_paths.dart) and
[`route_names.dart`](../lib/src/core/router/route_names.dart), so a link is
built from a constant rather than a string literal.

`onException` sends an unresolvable location back to the root instead of
showing an error page: every route here is reachable from a deep link, and an
unknown one is a stale link, not a failure the user can act on.

Two properties of the current setup are worth knowing before changing it.
`AppRouter.router` is a static singleton, read directly by the root widget and
by the deep link wiring rather than resolved through a provider, so a test
cannot substitute it: `pump_router_app.dart` drives the production router and
resets its location in `tearDown`. And the sample route reads its arguments
from `state.extra` with a non-null cast, so an entry that does not carry them,
such as a deep link or a restored stack, fails there.

## Deep links

[`DeepLinkService`](../lib/src/core/services/deep_link_service.dart) listens on
`app_links` and forwards each URI to
[`DeepLinkHandler`](../lib/src/core/helpers/deep_link_handler.dart), which
resolves it into a
[`DeepLinkTarget`](../lib/src/core/helpers/deep_link_target.dart) and navigates.

`DeepLinkTarget` is a sealed class of plain data with no side effects. The
parsing is the part with edge cases, so it is separated from navigation and
localization and unit tested on its own; the handler is left with the part that
needs a `BuildContext`.

## Persistence

Only user preferences: the theme, the language and the code theme. There is no
database.

[`SharedPreferencesService`](../lib/src/core/services/shared_preferences_service.dart)
wraps the plugin, and the keys live in one place, in
[`shared_preferences_keys.dart`](../lib/src/core/shared_preferences_keys.dart).
A repository talks to the service, never to `SharedPreferences` directly, which
is what lets a test swap the storage without touching the plugin.

The language repository maps a stored `pt_BR` to `pt` on read. Versions before
the region-qualified ARB file was dropped wrote that value, and it no longer
matches any entry of `Language.all`, so without the mapping an upgrade would
silently reset a user's language to English.

## Theming

[`theme.dart`](../lib/src/core/theme/theme.dart) holds the light and dark
`ThemeData`, and
[`ThemeNotifier`](../lib/src/core/theme/theme_notifier.dart) holds the selected
mode and persists it. The code theme is a separate feature, because it is a
different choice with a different set of options: it selects the palette used
by `flutter_syntax_highlighter` when rendering a sample.

## Localization

Three languages: English, Spanish and Portuguese. The ARB files are language
only, with no region, so a pt-PT device gets Portuguese rather than falling
back to English.

`app_en.arb` is the template and carries a description for every key, which is
the only context a translator gets.
[`check_l10n.sh`](../scripts/check_l10n.sh) enforces both the descriptions and
key parity, because `gen-l10n` falls back to the template in silence when a key
is missing from a language.

The generated output is committed, and CI regenerates it to prove the commit
matches its source.

## The catalog samples

[`features/catalog/data/samples/`](../lib/src/features/catalog/data/samples)
holds 226 files, and they are the product: the code the app shows the user as
teaching material. They are data, not app code, and follow different rules on
purpose.

- **Literals stay inline.** A sample that reads a spacing token teaches a token
  the reader cannot see the value of.
- **They are excluded from the coverage gate.** Their 6967 coverable lines drag
  the reported figure from 95% to 24% while saying nothing about the app. The
  exclusion lives in [`check_coverage.sh`](../scripts/check_coverage.sh) and is
  repeated in `codecov.yml`.
- **Registration, not wiring.** A sample is a `ComponentModel` in
  `sample_definitions/`, named by a constant in `sample_names/`, and resolved
  by `SampleRegistry`. Adding one means adding a list entry.

`sample_registry_test.dart` resolves every registered component, so a sample
missing from a definition list fails there rather than at runtime.

## Ads

`google_mobile_ads`, initialized in `main.dart` and read from `.env` through
`flutter_dotenv`. The unit ids are not in the repository; the keys have to
exist for the app to run, which is why `contributing.md` carries a `.env`
block with empty values.

The initialization is deliberately not awaited: an ad SDK that is slow to
answer should not hold up the first frame.

## Testing

`test/` mirrors `lib/src/` file for file. Doubles are `mocktail` mocks, and a
dependency is replaced through a `ProviderContainer` override rather than by
reaching into the widget tree. `test/helpers/` carries the harness:
`pumpApp` for a widget under a localized `MaterialApp`, `pumpScopedApp` for one
that opens overlay content, and `pump_router_app.dart` for anything routed.

The coverage gate is 90%, measured over `lib/` minus the generated sources and
the catalog samples.
