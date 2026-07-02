import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/features/settings/domain/repositories/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  LanguageRepositoryImpl(this._preferences);

  final SharedPreferencesService _preferences;

  @override
  String getSelectedLanguage() {
    return _preferences.getString(
      SharedPreferencesKeys.languageKey,
      defaultValue: LanguagesApp.en,
    );
  }

  @override
  Future<void> saveLanguage(String code) {
    return _preferences.setString(
      SharedPreferencesKeys.languageKey,
      code,
    );
  }
}
