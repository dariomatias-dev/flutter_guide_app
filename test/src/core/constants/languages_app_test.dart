import 'package:flutter/widgets.dart';
import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LanguagesApp.locale', () {
    test('returns the English locale', () {
      expect(LanguagesApp.locale(LanguagesApp.en), const Locale('en'));
    });

    test('returns the Brazilian Portuguese locale', () {
      expect(
        LanguagesApp.locale(LanguagesApp.ptBr),
        const Locale('pt', 'BR'),
      );
    });

    test('returns the Spanish locale', () {
      expect(LanguagesApp.locale(LanguagesApp.es), const Locale('es'));
    });

    test('falls back to English for an unknown code', () {
      expect(LanguagesApp.locale('unknown'), const Locale('en'));
    });
  });
}
