import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/providers/code_theme_repository_provider.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/providers/code_theme_view_model_provider.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/view_models/code_theme_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/mocks.dart';

void main() {
  late MockCodeThemeRepository repository;

  final initial = CodeTheme(
    selectedLightTheme: SyntaxThemes.vsCodeLight,
    selectedDarkTheme: SyntaxThemes.vsCodeDark,
  );

  setUp(() {
    repository = MockCodeThemeRepository();
    when(() => repository.getSelectedTheme()).thenReturn(initial);
    when(() => repository.saveLightTheme(any())).thenAnswer((_) async {});
    when(() => repository.saveDarkTheme(any())).thenAnswer((_) async {});
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        codeThemeRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  CodeThemeViewModel notifier(ProviderContainer c) =>
      c.read(codeThemeViewModelProvider.notifier);

  group('CodeThemeViewModel', () {
    test('build returns the selected theme from the repository', () {
      final state = makeContainer().read(codeThemeViewModelProvider);

      expect(state.selectedLightTheme, SyntaxThemes.vsCodeLight);
      expect(state.selectedDarkTheme, SyntaxThemes.vsCodeDark);
    });

    test('updateTheme with isDark true updates dark and keeps light', () async {
      final container = makeContainer();

      await notifier(container).updateTheme(
        name: 'Dracula',
        schema: SyntaxThemes.dracula,
        isDark: true,
      );

      final state = container.read(codeThemeViewModelProvider);
      expect(state.selectedDarkTheme, SyntaxThemes.dracula);
      expect(state.selectedLightTheme, SyntaxThemes.vsCodeLight);
      verify(() => repository.saveDarkTheme('Dracula')).called(1);
      verifyNever(() => repository.saveLightTheme(any()));
    });

    test('updateTheme with isDark false updates light and keeps dark',
        () async {
      final container = makeContainer();

      await notifier(container).updateTheme(
        name: 'GitHub Light',
        schema: SyntaxThemes.githubLight,
        isDark: false,
      );

      final state = container.read(codeThemeViewModelProvider);
      expect(state.selectedLightTheme, SyntaxThemes.githubLight);
      expect(state.selectedDarkTheme, SyntaxThemes.vsCodeDark);
      verify(() => repository.saveLightTheme('GitHub Light')).called(1);
      verifyNever(() => repository.saveDarkTheme(any()));
    });
  });
}
