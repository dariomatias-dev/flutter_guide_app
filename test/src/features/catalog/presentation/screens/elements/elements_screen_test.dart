import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/elements_screen_tab_index_notifier_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/components_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/elements/elements_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/view_models/elements_screen_tab_index_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../helpers/pump_app.dart';
import '../../../../../../helpers/pump_router_app.dart';

/// A tab index notifier that starts at an arbitrary index.
class _NotifierStartingAt extends ElementsScreenTabIndexNotifier {
  _NotifierStartingAt(this.initialIndex);

  final int initialIndex;

  @override
  int build() => initialIndex;
}

void main() {
  late SharedPreferences prefs;
  late ProviderContainer container;

  setUp(() async {
    prefs = await createMockPrefs();
  });

  Future<AppLocalizations> pumpScreen(
    WidgetTester tester, {
    int? initialIndex,
  }) async {
    container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        adsEnabledProvider.overrideWithValue(false),
        if (initialIndex != null)
          elementsScreenTabIndexNotifierProvider.overrideWith(
            () => _NotifierStartingAt(initialIndex),
          ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpApp(
      UncontrolledProviderScope(
        container: container,
        child: const ElementsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    return AppLocalizations.of(tester.element(find.byType(ElementsScreen)))!;
  }

  ComponentsScreen visibleList(WidgetTester tester) {
    return tester.widget<ComponentsScreen>(find.byType(ComponentsScreen));
  }

  group('ElementsScreen', () {
    testWidgets('renders both tabs', (tester) async {
      final l10n = await pumpScreen(tester);

      expect(find.text(l10n.widgets), findsOneWidget);
      expect(find.text(l10n.functions), findsOneWidget);
    });

    testWidgets('opens on the widgets tab', (tester) async {
      await pumpScreen(tester);

      expect(visibleList(tester).componentType, ComponentType.widget);
    });

    testWidgets('switches to the functions tab when tapped', (tester) async {
      final l10n = await pumpScreen(tester);

      await tester.tap(find.text(l10n.functions));
      await tester.pumpAndSettle();

      expect(visibleList(tester).componentType, ComponentType.function);
      expect(container.read(elementsScreenTabIndexNotifierProvider), 1);
    });

    testWidgets('follows the notifier when the index changes elsewhere', (
      tester,
    ) async {
      await pumpScreen(tester);

      container.read(elementsScreenTabIndexNotifierProvider.notifier).index = 1;
      await tester.pumpAndSettle();

      expect(visibleList(tester).componentType, ComponentType.function);
    });

    testWidgets('restores the tab the notifier already holds', (tester) async {
      await pumpScreen(tester, initialIndex: 1);

      expect(visibleList(tester).componentType, ComponentType.function);
    });
  });

  group('ElementsScreen out of range index', () {
    testWidgets('clamps a negative saved index to the first tab', (
      tester,
    ) async {
      await pumpScreen(tester, initialIndex: -1);

      // The controller is clamped, so the tab bar stays on the first tab
      // even though the notifier still reports the stale value.
      final tabBar = tester.widget<TabBar>(find.byType(TabBar));

      expect(tabBar.controller?.index, 0);
    });

    testWidgets('clamps a too large saved index to the first tab', (
      tester,
    ) async {
      await pumpScreen(tester, initialIndex: 5);

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));

      expect(tabBar.controller?.index, 0);
    });

    testWidgets('ignores an out of range index pushed at runtime', (
      tester,
    ) async {
      await pumpScreen(tester);

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));

      container.read(elementsScreenTabIndexNotifierProvider.notifier).index = 7;
      await tester.pumpAndSettle();

      expect(tabBar.controller?.index, 0);
    });
  });
}
