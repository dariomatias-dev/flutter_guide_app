import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/providers/components_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/data/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/components_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/saved_components/saved_components_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../helpers/mocks.dart';
import '../../../../../../helpers/pump_app.dart';

void main() {
  late MockComponentsRepository componentsRepository;
  late MockFavoritesRepository favoritesRepository;

  setUpAll(() {
    registerFallbackValue(ComponentType.widget);
  });

  setUp(() {
    componentsRepository = MockComponentsRepository();
    favoritesRepository = MockFavoritesRepository();
    when(
      () => favoritesRepository.getSavedComponentNames(any()),
    ).thenReturn([]);
  });

  Future<Widget> scope(ComponentType type) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        componentsRepositoryProvider.overrideWithValue(componentsRepository),
        favoritesRepositoryProvider.overrideWithValue(favoritesRepository),
      ],
      child: SavedComponentsScreen(componentType: type),
    );
  }

  group('SavedComponentsScreen', () {
    testWidgets('shows the empty state when nothing is saved', (
      tester,
    ) async {
      when(
        () => favoritesRepository.getSavedComponentNames(ComponentType.widget),
      ).thenReturn([]);
      when(
        () => componentsRepository.getComponentsByType(ComponentType.widget),
      ).thenReturn(const <Component>[]);

      await tester.pumpApp(await scope(ComponentType.widget));

      final l10n = AppLocalizations.of(
        tester.element(find.byType(SavedComponentsScreen)),
      );

      expect(find.text(l10n.noWidgetSaved), findsOneWidget);
      expect(find.byType(ComponentsScreen), findsNothing);
    });

    testWidgets('lists the saved components when there are some', (
      tester,
    ) async {
      when(
        () => favoritesRepository.getSavedComponentNames(ComponentType.widget),
      ).thenReturn(['Container']);
      when(
        () => componentsRepository.getComponentsByType(ComponentType.widget),
      ).thenReturn(const <Component>[
        Component(name: 'Container', type: ComponentType.widget),
        Component(name: 'Row', type: ComponentType.widget),
      ]);

      await tester.pumpApp(await scope(ComponentType.widget));

      expect(find.byType(ComponentsScreen), findsOneWidget);
      expect(find.text('Container'), findsOneWidget);
      expect(find.text('Row'), findsNothing);
    });

    testWidgets('titles the function list and its empty state', (
      tester,
    ) async {
      when(
        () =>
            favoritesRepository.getSavedComponentNames(ComponentType.function),
      ).thenReturn([]);
      when(
        () => componentsRepository.getComponentsByType(ComponentType.function),
      ).thenReturn(const <Component>[]);

      await tester.pumpApp(await scope(ComponentType.function));

      final l10n = AppLocalizations.of(
        tester.element(find.byType(SavedComponentsScreen)),
      );

      expect(find.text(l10n.savedFunctions), findsOneWidget);
      expect(find.text(l10n.noFunctionSaved), findsOneWidget);
    });

    testWidgets('titles the package list for a package type', (tester) async {
      when(
        () => favoritesRepository.getSavedComponentNames(ComponentType.package),
      ).thenReturn([]);
      when(
        () => componentsRepository.getComponentsByType(ComponentType.package),
      ).thenReturn(const <Component>[]);

      await tester.pumpApp(await scope(ComponentType.package));

      final l10n = AppLocalizations.of(
        tester.element(find.byType(SavedComponentsScreen)),
      );

      expect(find.text(l10n.savedPackages), findsOneWidget);
      expect(find.text(l10n.noPackageSaved), findsOneWidget);
    });
  });
}
