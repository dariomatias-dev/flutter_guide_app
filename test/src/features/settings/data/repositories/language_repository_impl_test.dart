import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/features/settings/data/repositories/language_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late LanguageRepositoryImpl repository;
  late SharedPreferencesService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();
    service = SharedPreferencesService(prefs);
    repository = LanguageRepositoryImpl(service);
  });

  group('LanguageRepositoryImpl', () {
    test('getSelectedLanguage defaults to English when unset', () {
      expect(repository.getSelectedLanguage(), LanguagesApp.en);
    });

    test('getSelectedLanguage returns the saved language', () async {
      await repository.saveLanguage(LanguagesApp.ptBr);

      expect(repository.getSelectedLanguage(), LanguagesApp.ptBr);
    });

    test('saveLanguage persists under the language key', () async {
      await repository.saveLanguage(LanguagesApp.es);

      expect(
        service.getStringOrNull(SharedPreferencesKeys.languageKey),
        LanguagesApp.es,
      );
    });
  });
}
