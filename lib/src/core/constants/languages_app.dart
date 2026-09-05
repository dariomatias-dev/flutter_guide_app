import 'package:flutter/cupertino.dart';

/// Supported app languages and their locales.
abstract final class LanguagesApp {
  /// English language code.
  static const en = 'en';

  /// Portuguese language code, matching any Portuguese device.
  static const pt = 'pt';

  /// Language code stored by versions that shipped a pt_BR-only translation.
  /// Reads still accept it so an existing choice survives the upgrade.
  static const legacyPtBr = 'pt_BR';

  /// Spanish language code.
  static const es = 'es';

  static const Map<String, Locale> _languageLocales = {
    en: Locale('en'),
    pt: Locale('pt'),
    legacyPtBr: Locale('pt'),
    es: Locale('es'),
  };

  /// Returns the [Locale] for [language], falling back to English.
  static Locale locale(
    String language,
  ) {
    return _languageLocales[language] ?? _languageLocales[en]!;
  }
}
