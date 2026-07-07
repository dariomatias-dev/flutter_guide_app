import 'dart:ui';

/// Localization helpers for the app's supported locales.
abstract final class L10n {
  /// All supported locales.
  static final all = <Locale>[
    const Locale('en', ''),
    const Locale('pt', 'BR'),
  ];

  /// Whether [locale] is English.
  static bool isEnglish(Locale locale) => locale.languageCode == 'en';

  /// Whether [locale] is Portuguese.
  static bool isPortuguese(Locale locale) => locale.languageCode == 'pt';
}
