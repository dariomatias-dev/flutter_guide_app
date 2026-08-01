# Changelog

All notable changes to this project are documented in this file.

## [Unreleased]

### Added
- Spanish localization, alongside existing Portuguese (BR) and English
- Semantic labels for interactive elements (accessibility)
- Provider to disable ad banners
- Automated marketing screenshot capture
- New catalog samples: remaining Cupertino widgets, `DataTable` /
  `PaginatedDataTable`, `ClipPath`, `Flow`, `Draggable`, `Positioned`,
  `Flexible`, dialog/menu/search functions, `ExpansionPanelList`,
  `SearchBar`, `Stepper`, `DropdownMenu`, `Table`, and the `expandable`,
  `flutter_staggered_grid_view`, and `shimmer` packages
- Home screen component groups expanded to cover the full widget catalog
  and localized

### Changed
- Rewrote the app architecture on Riverpod (view models/notifiers)
  organized by feature (catalog, settings, home, code theme selector),
  replacing legacy controllers and `InheritedWidget`s
- Centralized repositories and data sources for catalog, favorites,
  language, code theme, and app version
- Brought the codebase up to `very_good_analysis` standards
- Updated the Flutter SDK and dependencies
- Rewrote the README with a setup guide and PT-BR/ES translations

### Fixed
- Controller leaks across several catalog samples
- Search state resetting on unrelated rebuilds
- Inverted "load more" logic in the infinite scroll sample
- Non-reactive colors and stale widgets on theme change
- Remaining hardcoded strings not routed through localization

## [1.2.3] - 2025-09-05
### Changed
- Removed the donation dialog and the `Expanded` wrapper from the dialog
  button widget
- Standardized app links

### Fixed
- Theme not applying correctly after opening the app from a deep link

## [1.2.2] - 2025-09-03
### Added
- Redesigned dialog components (new dialog, line, and button widgets),
  replacing the old dialog implementation
- Localization for the "open URL" error dialog
- Accepted URL prefixes for Android deep links
- Distinction between dialog types and `SafeArea` usage in the
  `showDialog`/`showModalBottomSheet` samples

### Changed
- Repositioned the portfolio link

### Fixed
- Minor issues in the `showBottomSheet` sample and the about dialog

## [1.2.1] - 2025-08-30
### Added
- Android package name declaration
- Method to clear open screens on deep link handling

### Changed
- Standardized the app name
- Updated package sample URLs

### Fixed
- Duplicate screen opening on deep link

## [1.2.0] - 2025-08-27
### Added
- Code theme selector: choose the syntax-highlighting theme for code
  samples, with persistence and light/dark support
- App and deep link support across widgets, functions, packages, elements,
  and UI samples, including component sharing and invalid-link handling
- `scroll_infinity` package sample
- Home screen template option (later removed pending further design)

### Changed
- Improved README structure and content
- Simplified the elements screen tab index control
- Updated `flutter_syntax_highlighter` and removed the "Buy Me a Coffee"
  settings entry

### Fixed
- Saved app theme not being restored correctly
- Elements screen tab navigation issues

## [1.1.9] - 2025-07-27
### Changed
- Updated `flutter_syntax_highlighter`
- Added line-number character count handling to the code sample viewer

## [1.1.8] - 2025-07-22
### Changed
- Updated the Flutter SDK and `flutter_syntax_highlighter`
- Removed the unused `generated` folder

## [1.1.7] - 2025-07-20
### Added
- `flutter_syntax_highlighter` package sample
- Feedback option in the settings screen

### Changed
- Switched code highlighting to the `flutter_syntax_highlighter` package,
  replacing the custom solution
- Adapted the code sample theme to match the app theme
- Updated the `video_player` package

## [1.1.6] - 2025-07-16
### Added
- Text selection in the code sample viewer

### Changed
- Optimized `BannerAdWidget` usage inside infinite scroll lists

### Fixed
- Ad banner loading freeze
- Missing `SafeArea` in several package samples
- Layout issues in the emails UI sample

## [1.1.5] - 2025-07-15
### Added
- `InfinityScroll` component, replacing the previous infinite scroll
  implementation
- Custom Dart code styling and theme-aware code display in the code
  sample viewer, with text selection and line spacing controls

### Changed
- Simplified the main, home, and settings screens and several shared
  widgets (back button, search field, list tile, app bar, tab bar)
- Refactored the theme controller

### Fixed
- Duplicate initial item in headerless infinite scroll lists
- Rendering crash in `BannerAdWidget` without context
- Duplicate empty line in the code display

## [1.1.4] - 2025-07-13
### Added
- `SafeArea` around the bottom navigation bar
- Animation for component group items

### Changed
- Updated the Flutter version and app links
- Removed deprecated `withOpacity` usage
- Redesigned the chat screen sample
- Implemented `CustomDialog` in the settings screen

### Fixed
- Deprecated properties in sample components

## [1.1.3] - 2025-06-28
### Changed
- Reorganized sample and link classes into dedicated folders
  (`sample_definitions`, link classes)
- Redesigned the search field border
- Centralized sample definitions

## [1.1.2] - 2025-06-28
### Added
- Ad display in component group items
- Infinite scroll element in the interface catalog
- Portfolio access option in settings
- Dedicated class for app links

### Changed
- Renamed the ad component to `BannerAdWidget`
- Reversed the order of the UI/elements list tiles on the home screen
- Sorted the elements and UIs arrays

### Fixed
- Code block retrieval issue in the component sample screen
- Search field border and unfocus behavior
- Redundant state update on the elements screen
- Overlay removal error in the custom popup menu sample

## [1.1.1] - 2025-06-23
### Added
- Project README with app download and website sections

### Fixed
- Incorrect widget usage in the bottom navigation bar

## [1.1.0] - 2025-06-22
### Added
- `pinput` and `google_mobile_ads` package samples (banner, interstitial,
  rewarded, and app-open ad examples)
- PIN entry screen sample
- Test device registration for ads
- Access to the official site and privacy policy from settings

### Changed
- Simplified the search field design and bottom navigation bar
- Simplified controller initialization across shared widgets
- Expanded multi-language support in the settings screen

### Fixed
- Screen name display in the bottom navigation bar

## [1.0.3] - 2025-05-18
### Added
- Gesture navigation support and a larger touch area for the bottom
  navigation bar

### Fixed
- Incorrect Android organization name and application ID

## [1.0.2] - 2025-05-18
### Added
- Pagination in the code sample viewer, backed by `ListView` for better
  performance

## [1.0.1] - 2025-04-13
Initial public release.

### Added
- Full widget catalog covering Material and Cupertino components, forms,
  layout, navigation, dialogs, chips, progress indicators, and animation
  widgets
- Package sample gallery, including `url_launcher`, `dio`, `http`,
  `flutter_svg`, `flutter_spinkit`, `msh_checkbox`, `uuid`,
  `font_awesome_flutter`, `flutter_rating_bar`, `salomon_bottom_bar`,
  `share_plus`, `google_fonts`, `flutter_slidable`,
  `infinite_scroll_pagination`, `toastification`, `loading_animation_widget`,
  `shared_preferences`, `smooth_page_indicator`, `loading_indicator`,
  `carousel_slider`, `like_button`, `circular_countdown_timer`, `glass`,
  `dotted_border`, `bottom_navy_bar`, `flutter_animate`, `network_info_plus`,
  `video_player`, `photo_view`, `cached_network_image`,
  `flutter_chat_bubble`, `awesome_snackbar_content`, `battery_plus`, and
  `device_info_plus`
- UI examples: email client, chat screen, and login screen
- Elements screen with reusable patterns: custom dropdown, image loader,
  infinite scroll, loading button, password field, Dio configuration, and
  date/time pickers
- Favorites system to save widgets, packages, elements, and UIs
- Light/dark theme support with persisted preference
- Multi-language support (English and Portuguese) across screens and
  samples
- Code preview tab with copy-to-clipboard and access to official
  documentation and videos
- Home screen with component groups and search across the catalog

## [1.0.0] - 2024-03-21
Initial commit: project scaffolding.

[Unreleased]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.2.3...HEAD
[1.2.3]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.2.2...v1.2.3
[1.2.2]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.2.1...v1.2.2
[1.2.1]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.1.9...v1.2.0
[1.1.9]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.1.8...v1.1.9
[1.1.8]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.1.7...v1.1.8
[1.1.7]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.1.6...v1.1.7
[1.1.6]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.1.5...v1.1.6
[1.1.5]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.1.4...v1.1.5
[1.1.4]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.1.3...v1.1.4
[1.1.3]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.1.2...v1.1.3
[1.1.2]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.1.1...v1.1.2
[1.1.1]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.0.3...v1.1.0
[1.0.3]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/dariomatias-dev/flutter_guide_app/compare/v1.0.0...v1.0.1
