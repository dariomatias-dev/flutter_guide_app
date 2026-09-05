import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/features/settings/data/providers/language_repository_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/language_view_model_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/view_models/language_view_model.dart';
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

  LanguageViewModel notifier(ProviderContainer c) =>
      c.read(languageViewModelProvider.notifier);

  group('LanguageViewModel', () {
    test('build returns the selected language from the repository', () {
      when(
        () => repository.getSelectedLanguage(),
      ).thenReturn(LanguagesApp.pt);

      expect(
        makeContainer().read(languageViewModelProvider),
        LanguagesApp.pt,
      );
    });

    test('setLanguage updates the state and persists the code', () async {
      final container = makeContainer();

      await notifier(container).setLanguage(LanguagesApp.pt);

      expect(container.read(languageViewModelProvider), LanguagesApp.pt);
      verify(() => repository.saveLanguage(LanguagesApp.pt)).called(1);
    });
  });
}
