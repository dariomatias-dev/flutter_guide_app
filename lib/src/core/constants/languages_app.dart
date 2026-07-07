import 'package:flutter/cupertino.dart';

/// Supported app languages and their locales.
abstract final class LanguagesApp {
  /// English language code.
  static const en = 'en';

  /// Brazilian Portuguese language code.
  static const ptBr = 'pt_BR';

  /// Spanish language code.
  static const es = 'es';

  static const Map<String, Locale> _languageLocales = {
    en: Locale('en'),
    ptBr: Locale('pt', 'BR'),
    es: Locale('es'),
  };

  /// Returns the [Locale] for [language], falling back to English.
  static Locale locale(
    String language,
  ) {
    return _languageLocales[language] ?? _languageLocales[en]!;
  }
}
