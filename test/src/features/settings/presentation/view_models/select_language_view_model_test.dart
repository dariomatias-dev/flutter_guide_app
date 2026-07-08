import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/features/settings/domain/entities/language.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/language_repository_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/select_language_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/mocks.dart';

void main() {
  late MockLanguageRepository repository;

  setUp(() {
    repository = MockLanguageRepository();
    when(() => repository.getSelectedLanguage()).thenReturn(LanguagesApp.en);
    when(() => repository.saveLanguage(any())).thenAnswer((_) async {});
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        languageRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('SelectLanguageViewModel', () {
    test('build resolves the Language matching the selected code', () {
      when(() => repository.getSelectedLanguage())
          .thenReturn(LanguagesApp.ptBr);

      final language = makeContainer().read(selectLanguageViewModelProvider);

      expect(language.code, LanguagesApp.ptBr);
    });

    test('build falls back to the first language for an unknown code', () {
      when(() => repository.getSelectedLanguage()).thenReturn('xx');

      final language = makeContainer().read(selectLanguageViewModelProvider);

      expect(language, Language.all.first);
    });

    test('selectLanguage persists the chosen code', () async {
      final container = makeContainer();
      container
          .read(selectLanguageViewModelProvider.notifier)
          .selectLanguage(LanguagesApp.ptBr);

      await Future<void>.delayed(Duration.zero);

      verify(() => repository.saveLanguage(LanguagesApp.ptBr)).called(1);
    });
  });
}
