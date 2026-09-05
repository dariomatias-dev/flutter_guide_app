import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/providers/components_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/data/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/component_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../helpers/mocks.dart';
import '../../../../../../helpers/pump_app.dart';
import '../../../../../../helpers/url_launcher_fake.dart';

const _component = Component(name: 'Center', type: ComponentType.widget);

void main() {
  late MockComponentsRepository componentsRepository;
  late MockFavoritesRepository favoritesRepository;

  setUpAll(() {
    registerFallbackValue(ComponentType.widget);
  });

  setUp(() {
    componentsRepository = MockComponentsRepository();
    when(
      () => componentsRepository.getComponentByName(
        type: any(named: 'type'),
        name: any(named: 'name'),
      ),
    ).thenReturn(_component);

    favoritesRepository = MockFavoritesRepository();
    when(
      () => favoritesRepository.getSavedComponentNames(any()),
    ).thenReturn([]);
    when(
      () => favoritesRepository.toggleFavorite(
        type: any(named: 'type'),
        name: any(named: 'name'),
      ),
    ).thenReturn(true);
  });

  Future<Widget Function(Widget app)> scope() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // The annotation is required here: without it the closure's return type
    // can't be inferred as `Widget`, which then breaks `pumpScopedApp`'s
    // `Widget Function(Widget)` parameter.
    // ignore: avoid_types_on_closure_parameters
    return (Widget app) => ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        componentsRepositoryProvider.overrideWithValue(
          componentsRepository,
        ),
        favoritesRepositoryProvider.overrideWithValue(
          favoritesRepository,
        ),
      ],
      child: app,
    );
  }

  const componentScreen = ComponentScreen(
    componentType: ComponentType.widget,
    componentName: 'Center',
  );

  testWidgets('renders the title and the component sample', (tester) async {
    await tester.pumpScopedApp(await scope(), componentScreen);
    await tester.pump();

    expect(find.text('Center'), findsWidgets);
  });

  testWidgets('toggles the favorite state from the popup menu', (
    tester,
  ) async {
    await tester.pumpScopedApp(await scope(), componentScreen);
    await tester.pump();

    await tester.tap(find.byType(PopupMenuButton<dynamic>));
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(ComponentScreen));
    final l10n = AppLocalizations.of(context);

    await tester.tap(find.text(l10n.save));
    await tester.pumpAndSettle();

    verify(
      () => favoritesRepository.toggleFavorite(
        type: ComponentType.widget,
        name: 'Center',
      ),
    ).called(1);
  });

  testWidgets('opens the YouTube url from the popup menu when set', (
    tester,
  ) async {
    when(
      () => componentsRepository.getComponentByName(
        type: any(named: 'type'),
        name: any(named: 'name'),
      ),
    ).thenReturn(
      const Component(
        name: 'Center',
        type: ComponentType.widget,
        videoId: 'abc123',
      ),
    );

    final urlLauncher = FakeUrlLauncherPlatform()..install();
    addTearDown(urlLauncher.restore);

    await tester.pumpScopedApp(await scope(), componentScreen);
    await tester.pump();

    await tester.tap(find.byType(PopupMenuButton<dynamic>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('YouTube'));
    await tester.pumpAndSettle();

    expect(
      urlLauncher.launchedUrls,
      <String>['https://www.youtube.com/watch?v=abc123'],
    );
  });

  for (final type in <ComponentType>[
    ComponentType.material,
    ComponentType.cupertino,
    ComponentType.elements,
    ComponentType.uis,
  ]) {
    testWidgets('throws for $type, which never routes here', (tester) async {
      await tester.pumpScopedApp(
        await scope(),
        ComponentScreen(componentType: type, componentName: 'Center'),
      );

      expect(tester.takeException(), isStateError);
    });
  }
}
