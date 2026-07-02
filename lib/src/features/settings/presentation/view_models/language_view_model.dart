import 'package:flutter_guide/src/features/settings/domain/repositories/language_repository.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/language_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageViewModel extends Notifier<String> {
  late final LanguageRepository _repository = ref.read(
    languageRepositoryProvider,
  );

  @override
  String build() {
    return _repository.getSelectedLanguage();
  }

  Future<void> setLanguage(String code) async {
    state = code;

    await _repository.saveLanguage(code);
  }
}
