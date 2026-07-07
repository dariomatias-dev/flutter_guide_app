/// Persists and reads the user's selected language.
abstract class LanguageRepository {
  /// Returns the selected language code.
  String getSelectedLanguage();

  /// Persists the selected language [code].
  Future<void> saveLanguage(String code);
}
