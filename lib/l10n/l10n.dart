import 'dart:ui';

class L10n {
  static final all = <Locale>[
    const Locale('en', ''),
    const Locale('pt', 'BR'),
  ];

  static bool isEnglish(Locale locale) => locale.languageCode == 'en';

  static bool isPortuguese(Locale locale) => locale.languageCode == 'pt';
}
