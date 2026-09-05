import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/features/settings/domain/repositories/language_repository.dart';

/// Default [LanguageRepository] backed by `SharedPreferences`.
class LanguageRepositoryImpl implements LanguageRepository {
  /// Creates a [LanguageRepositoryImpl].
  LanguageRepositoryImpl(this._preferences);

  final SharedPreferencesService _preferences;

  @override
  String getSelectedLanguage() {
    final stored = _preferences.getString(
      SharedPreferencesKeys.languageKey,
      defaultValue: LanguagesApp.en,
    );

    // Versions before the pt_BR arb was dropped stored the region-qualified
    // code, which no longer matches any entry of Language.all.
    return stored == LanguagesApp.legacyPtBr ? LanguagesApp.pt : stored;
  }

  @override
  Future<void> saveLanguage(String code) {
    return _preferences.setString(
      SharedPreferencesKeys.languageKey,
      code,
    );
  }
}
