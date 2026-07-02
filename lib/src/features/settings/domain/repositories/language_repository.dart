abstract class LanguageRepository {
  String getSelectedLanguage();

  Future<void> saveLanguage(String code);
}
