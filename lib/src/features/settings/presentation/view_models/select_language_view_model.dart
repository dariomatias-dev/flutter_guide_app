import 'package:flutter_guide/src/features/settings/domain/entities/language_entity.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/language_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectLanguageViewModel extends Notifier<LanguageEntity> {
  @override
  LanguageEntity build() {
    final code = ref.watch(languageViewModelProvider);

    return LanguageEntity.all.firstWhere(
      (language) => language.code == code,
      orElse: () => LanguageEntity.all.first,
    );
  }

  void selectLanguage(String code) {
    ref.read(languageViewModelProvider.notifier).setLanguage(code);
  }
}
