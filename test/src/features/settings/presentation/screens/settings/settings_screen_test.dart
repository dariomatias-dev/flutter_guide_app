import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/constants/links/app_links.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/screens/code_theme_selector_screen.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/app_version_repository_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/screens/settings/settings_screen.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/about_dialog_widget.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/app_info_widget/app_info_widget.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/docs_and_resources_dialog_widget.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/select_language_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../helpers/pump_app.dart';
import '../../../../../../helpers/pump_router_app.dart';
import '../../../../../../helpers/url_launcher_fake.dart';

void main() {
  late SharedPreferences prefs;
  late FakeUrlLauncherPlatform urlLauncher;

  setUp(() async {
    prefs = await createMockPrefs();
    urlLauncher = FakeUrlLauncherPlatform()..install();
  });

  tearDown(() {
    urlLauncher.restore();
    resetRouterLocation();
  });

  /// Pumps the settings screen on its own, outside the navigation shell.
  ///
  /// `pumpScopedApp` is required because the screen opens dialogs, which
  /// attach to the app's root overlay above a nested `ProviderScope`.
  Future<AppLocalizations> pumpSettings(WidgetTester tester) async {
    await tester.pumpScopedApp(
      // The explicit type is required for `pumpScopedApp` to infer the
      // closure as `Widget Function(Widget)`.
      // ignore: avoid_types_on_closure_parameters
      (Widget app) => ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          adsEnabledProvider.overrideWithValue(false),
          appVersionRepositoryProvider.overrideWithValue(
            () async => '1.2.3+4',
          ),
        ],
        child: app,
      ),
      const SettingsScreen(),
    );
    await tester.pumpAndSettle();

    return AppLocalizations.of(tester.element(find.byType(SettingsScreen)))!;
  }

  group('SettingsScreen', () {
    testWidgets('renders every settings entry', (tester) async {
      final l10n = await pumpSettings(tester);

      expect(find.byType(AppInfoWidget), findsOneWidget);
      expect(find.byType(SelectLanguageWidget), findsOneWidget);
      expect(find.text(l10n.docsAndResources), findsOneWidget);
      expect(find.text(l10n.codeTheme), findsOneWidget);
      expect(find.text(l10n.developerPortfolio), findsOneWidget);
      expect(find.text(l10n.officialSite), findsOneWidget);
      expect(find.text(l10n.privacyPolicy), findsOneWidget);
      expect(find.text(l10n.feedback), findsOneWidget);
      expect(find.text(l10n.about), findsOneWidget);
    });

    testWidgets('shows the resolved app version', (tester) async {
      final l10n = await pumpSettings(tester);

      expect(find.text('${l10n.version} 1.2.3+4'), findsOneWidget);
    });
  });

  group('SettingsScreen external links', () {
    for (final entry in <String, String>{
      'developerPortfolio': AppLinks.myWebsite,
      'officialSite': AppLinks.officialSite,
      'privacyPolicy': AppLinks.privacyPolicy,
    }.entries) {
      testWidgets('${entry.key} opens its url', (tester) async {
        final l10n = await pumpSettings(tester);

        final label = switch (entry.key) {
          'developerPortfolio' => l10n.developerPortfolio,
          'officialSite' => l10n.officialSite,
          _ => l10n.privacyPolicy,
        };

        await tester.tap(find.text(label));
        await tester.pumpAndSettle();

        expect(urlLauncher.launchedUrls, <String>[entry.value]);
      });
    }

    testWidgets('feedback opens the English form under an English locale', (
      tester,
    ) async {
      final l10n = await pumpSettings(tester);

      await tester.tap(find.text(l10n.feedback));
      await tester.pumpAndSettle();

      expect(urlLauncher.launchedUrls, <String>[AppLinks.feedbackFormLinkEn]);
    });
  });

  group('SettingsScreen docs and resources dialog', () {
    testWidgets('opens with every documentation link', (tester) async {
      final l10n = await pumpSettings(tester);

      await tester.tap(find.text(l10n.docsAndResources));
      await tester.pumpAndSettle();

      expect(find.byType(DocsAndResourcesDialogWidget), findsOneWidget);
      expect(find.text(l10n.flutterDocs), findsOneWidget);
      expect(find.text(l10n.dartDocs), findsOneWidget);
      expect(find.text('Dart Pad'), findsOneWidget);
      expect(find.text('pub.dev - ${l10n.packages}'), findsOneWidget);
      expect(find.text(l10n.samples), findsOneWidget);
    });

    testWidgets('opens the url of a tapped entry', (tester) async {
      final l10n = await pumpSettings(tester);

      await tester.tap(find.text(l10n.docsAndResources));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Dart Pad'));
      await tester.pumpAndSettle();

      expect(urlLauncher.launchedUrls, <String>[AppLinks.dartPad]);
    });

    testWidgets('closes when Ok is tapped', (tester) async {
      final l10n = await pumpSettings(tester);

      await tester.tap(find.text(l10n.docsAndResources));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ok'));
      await tester.pumpAndSettle();

      expect(find.byType(DocsAndResourcesDialogWidget), findsNothing);
    });
  });

  group('SettingsScreen about dialog', () {
    testWidgets('opens with the app description', (tester) async {
      final l10n = await pumpSettings(tester);

      await tester.tap(find.text(l10n.about));
      await tester.pumpAndSettle();

      expect(find.byType(AboutDialogWidget), findsOneWidget);
      // `AppInfoWidget` behind the dialog shows the same name.
      expect(
        find.descendant(
          of: find.byType(AboutDialogWidget),
          matching: find.text('FlutterGuide'),
        ),
        findsOneWidget,
      );
      expect(find.text(l10n.aboutDescription), findsOneWidget);
    });

    testWidgets('opens the Play Store listing', (tester) async {
      final l10n = await pumpSettings(tester);

      await tester.tap(find.text(l10n.about));
      await tester.pumpAndSettle();

      await tester.tap(find.text(l10n.viewOnPlayStore));
      await tester.pumpAndSettle();

      expect(
        urlLauncher.launchedUrls,
        <String>[AppLinks.playStoreDownload],
      );
    });
  });

  group('SettingsScreen language menu', () {
    testWidgets('starts on English', (tester) async {
      await pumpSettings(tester);

      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('lists every supported language', (tester) async {
      await pumpSettings(tester);

      await tester.tap(find.byType(SelectLanguageWidget));
      await tester.pumpAndSettle();

      expect(find.text('Português'), findsOneWidget);
      expect(find.text('Español'), findsOneWidget);
    });

    testWidgets('persists the language picked from the menu', (tester) async {
      await pumpSettings(tester);

      await tester.tap(find.byType(SelectLanguageWidget));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Português'));
      await tester.pumpAndSettle();

      expect(find.text('Português'), findsOneWidget);
      expect(find.text('English'), findsNothing);
    });
  });

  group('SettingsScreen navigation', () {
    testWidgets('code theme opens the selector screen', (tester) async {
      // Driven through the real router: the row navigates with `AppRoutes`,
      // which needs a `GoRouter` above it.
      await tester.pumpRouterApp(prefs: prefs);

      // The shell opens on the home tab and the `PageView` builds lazily,
      // so the settings tab has to be selected before its rows exist.
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      final l10n = AppLocalizations.of(
        tester.element(find.byType(SettingsScreen)),
      )!;

      await tester.tap(find.text(l10n.codeTheme));
      await tester.pumpAndSettle();

      expect(find.byType(CodeThemeSelectorScreen), findsOneWidget);
    });
  });
}
