import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/constants/shared_preferences_keys.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/deep_link_source_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/shell/root_navigation.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/component_screen.dart';
import 'package:flutter_guide/src/features/settings/data/providers/app_version_repository_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/language_view_model_provider.dart';
import 'package:flutter_guide/src/flutter_guide_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fake_deep_link_source.dart';

void main() {
  late FakeDeepLinkSource deepLinks;

  setUp(() {
    deepLinks = createFakeDeepLinkSource();
  });

  /// Pumps the real root widget over mock preferences.
  ///
  /// Only what reaches outside the process is overridden: preferences, the ad
  /// switch, the package version and the link source. Theme, language, router
  /// and the deep link handler all resolve through the production graph,
  /// which is the wiring under test.
  Future<ProviderContainer> pumpRootApp(
    WidgetTester tester, {
    Map<String, Object> preferences = const <String, Object>{},
  }) async {
    SharedPreferences.setMockInitialValues(preferences);
    final prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        adsEnabledProvider.overrideWithValue(false),
        appVersionRepositoryProvider.overrideWithValue(() async => '1.0.0+1'),
        deepLinkSourceProvider.overrideWithValue(deepLinks),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const FlutterGuideApp(),
      ),
    );
    await tester.pump();

    return container;
  }

  /// The [MaterialApp] the root widget configured.
  MaterialApp materialApp(WidgetTester tester) {
    return tester.widget<MaterialApp>(find.byType(MaterialApp));
  }

  /// The system bar style the app itself declares.
  ///
  /// `Scaffold` and `AppBar` annotate regions of their own further down the
  /// tree, so the finder is anchored on the one wrapping `MaterialApp`.
  SystemUiOverlayStyle overlayStyle(WidgetTester tester) {
    return tester
        .widget<AnnotatedRegion<SystemUiOverlayStyle>>(
          find.ancestor(
            of: find.byType(MaterialApp),
            matching: find.byType(AnnotatedRegion<SystemUiOverlayStyle>),
          ),
        )
        .value;
  }

  testWidgets('renders the shell through the production router', (
    tester,
  ) async {
    await pumpRootApp(tester);

    expect(find.byType(RootNavigation), findsOneWidget);
    expect(materialApp(tester).routerConfig, isNotNull);
    expect(materialApp(tester).debugShowCheckedModeBanner, isFalse);
  });

  testWidgets('starts in dark mode when no theme was ever saved', (
    tester,
  ) async {
    await pumpRootApp(tester);

    expect(materialApp(tester).themeMode, ThemeMode.dark);
  });

  testWidgets('applies the saved light theme', (tester) async {
    await pumpRootApp(
      tester,
      preferences: {SharedPreferencesKeys.themeKey: ThemeMode.light.name},
    );

    expect(materialApp(tester).themeMode, ThemeMode.light);
  });

  group('system bar overlay style', () {
    testWidgets('keeps both bars transparent and their icons dark on light', (
      tester,
    ) async {
      await pumpRootApp(
        tester,
        preferences: {SharedPreferencesKeys.themeKey: ThemeMode.light.name},
      );

      final style = overlayStyle(tester);

      expect(style.statusBarColor, Colors.transparent);
      expect(style.systemNavigationBarColor, Colors.transparent);
      expect(style.statusBarIconBrightness, Brightness.dark);
      expect(style.statusBarBrightness, Brightness.light);
      expect(style.systemNavigationBarIconBrightness, Brightness.dark);
    });

    testWidgets('turns the icons light under the dark theme', (tester) async {
      await pumpRootApp(tester);

      final style = overlayStyle(tester);

      expect(style.statusBarIconBrightness, Brightness.light);
      expect(style.statusBarBrightness, Brightness.dark);
      expect(style.systemNavigationBarIconBrightness, Brightness.light);
    });
  });

  group('locale', () {
    testWidgets('defaults to English with nothing saved', (tester) async {
      await pumpRootApp(tester);

      expect(materialApp(tester).locale, const Locale(LanguagesApp.en));
    });

    testWidgets('follows the saved language', (tester) async {
      await pumpRootApp(
        tester,
        preferences: {SharedPreferencesKeys.languageKey: LanguagesApp.es},
      );

      expect(materialApp(tester).locale, const Locale(LanguagesApp.es));
    });

    testWidgets('keeps a legacy pt_BR choice on Portuguese, not English', (
      tester,
    ) async {
      await pumpRootApp(
        tester,
        preferences: {
          SharedPreferencesKeys.languageKey: LanguagesApp.legacyPtBr,
        },
      );

      expect(materialApp(tester).locale, const Locale(LanguagesApp.pt));
    });

    testWidgets('rebuilds when the language changes at runtime', (
      tester,
    ) async {
      final container = await pumpRootApp(tester);

      await container
          .read(languageViewModelProvider.notifier)
          .setLanguage(LanguagesApp.pt);
      await tester.pump();

      expect(materialApp(tester).locale, const Locale(LanguagesApp.pt));
    });
  });

  group('deep links', () {
    testWidgets('opens a link that arrives after the first frame', (
      tester,
    ) async {
      await pumpRootApp(tester);
      await tester.pumpAndSettle();

      deepLinks.emit(Uri.parse('/widgets/Card'));
      await tester.pumpAndSettle();

      expect(find.byType(ComponentScreen), findsOneWidget);
    });

    testWidgets('reports a link that resolves to nothing', (tester) async {
      await pumpRootApp(tester);
      await tester.pumpAndSettle();

      deepLinks.emit(Uri.parse('/packages/does-not-exist'));
      await tester.pumpAndSettle();

      expect(find.byType(ComponentScreen), findsNothing);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('stops listening once the app leaves the tree', (
      tester,
    ) async {
      await pumpRootApp(tester);
      await tester.pumpAndSettle();

      expect(deepLinks.isListening, isTrue);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();

      expect(deepLinks.isListening, isFalse);
    });
  });
}
