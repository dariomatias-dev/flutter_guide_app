import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/navigation/main_navigation_notifier.dart';
import 'package:flutter_guide/src/core/shell/root_navigation.dart';
import 'package:flutter_guide/src/core/shell/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/components_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/elements/elements_screen.dart';
import 'package:flutter_guide/src/features/home/home_screen.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/app_version_repository_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/screens/settings/settings_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A [MainNavigationNotifier] that starts on an arbitrary tab.
class _NotifierStartingAt extends MainNavigationNotifier {
  _NotifierStartingAt(this.initialIndex);

  final int initialIndex;

  @override
  int build() => initialIndex;
}

void main() {
  late SharedPreferences prefs;
  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    prefs = await SharedPreferences.getInstance();
  });

  /// Pumps the shell, optionally starting on [initialIndex].
  Future<void> pumpShell(WidgetTester tester, {int initialIndex = 0}) async {
    container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        adsEnabledProvider.overrideWithValue(false),
        appVersionRepositoryProvider.overrideWithValue(() async => '1.0.0+1'),
        mainNavigationNotifierProvider.overrideWith(
          () => _NotifierStartingAt(initialIndex),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: RootNavigation(),
        ),
      ),
    );
    await tester.pump();
  }

  int selectedIndex() => container.read(mainNavigationNotifierProvider);

  group('RootNavigation', () {
    testWidgets('renders the bottom bar with every tab label', (tester) async {
      await pumpShell(tester);

      final context = tester.element(find.byType(RootNavigation));
      final l10n = AppLocalizations.of(context)!;

      expect(find.byType(BottomNavigationBarWidget), findsOneWidget);
      expect(find.text(l10n.home), findsOneWidget);
      expect(find.text(l10n.elements), findsWidgets);
      expect(find.text(l10n.packages), findsWidgets);
      expect(find.text(l10n.settings), findsOneWidget);
    });

    testWidgets('shows the home tab first', (tester) async {
      await pumpShell(tester);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(selectedIndex(), 0);
    });

    testWidgets('opens on the tab the notifier already holds', (tester) async {
      await pumpShell(tester, initialIndex: 3);

      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('tapping a bottom bar item selects that tab', (tester) async {
      await pumpShell(tester);

      // The bar only lays out the selected item's label, so the icon is the
      // reliable hit target for an unselected tab.
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      expect(selectedIndex(), 3);
      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('changing the notifier animates the page view', (tester) async {
      await pumpShell(tester);

      container.read(mainNavigationNotifierProvider.notifier).index = 1;
      await tester.pumpAndSettle();

      expect(find.byType(ElementsScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('swiping the page view updates the notifier', (tester) async {
      await pumpShell(tester);

      await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
      await tester.pumpAndSettle();

      expect(selectedIndex(), 1);
      expect(find.byType(ElementsScreen), findsOneWidget);
    });

    testWidgets('reset returns the shell to the home tab', (tester) async {
      await pumpShell(tester, initialIndex: 2);

      expect(find.byType(ComponentsScreen), findsOneWidget);

      container.read(mainNavigationNotifierProvider.notifier).reset();
      await tester.pumpAndSettle();

      expect(selectedIndex(), 0);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('re-selecting the current tab does not animate', (
      tester,
    ) async {
      await pumpShell(tester);

      container.read(mainNavigationNotifierProvider.notifier).index = 0;
      await tester.pump();

      // No animation is scheduled, so a single pump settles the tree.
      expect(tester.hasRunningAnimations, isFalse);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
