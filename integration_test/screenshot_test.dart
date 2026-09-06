import 'package:app_ui/app_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/constants/shared_preferences_keys.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/deep_link_source_provider.dart';
import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/services/deep_link_source.dart';
import 'package:flutter_guide/src/core/shell/widgets/bottom_navigation_bar/navigation_bar_widget.dart';
import 'package:flutter_guide/src/features/home/widgets/border_list_tile_item_widget.dart';
import 'package:flutter_guide/src/flutter_guide_app.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Locales captured, in the order the README and Play Store listing use.
const _locales = <String>[
  LanguagesApp.en,
  LanguagesApp.pt,
  LanguagesApp.es,
];

/// A [DeepLinkSource] that never delivers a link.
///
/// The real one answers over the platform's Intent history, which a test
/// device can carry over between runs: a link opened once during manual
/// testing is redelivered as the "initial" link on a later cold start. A
/// screenshot run has no business depending on whatever intent the test
/// device happens to remember.
class _NoLinksSource implements DeepLinkSource {
  @override
  Future<Uri?> getInitialLink() async => null;

  @override
  Stream<Uri> get uriLinkStream => const Stream.empty();
}

/// Drives the app through its main screens in every supported locale,
/// taking a screenshot of each, so marketing assets (README, Play Store,
/// website) can be generated without manually navigating the app.
///
/// Run with:
///   flutter drive \
///     --driver=test_driver/integration_test.dart \
///     --target=integration_test/screenshot_test.dart
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture marketing screenshots', (tester) async {
    await dotenv.load();

    final sharedPreferences = await SharedPreferences.getInstance();

    await binding.convertFlutterSurfaceToImage();

    /// `pumpAndSettle` never returns: a collapsed [BannerAdWidget] still
    /// builds its indeterminate progress indicator while the real ad
    /// loads, which keeps scheduling frames forever.
    Future<void> settle() async {
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }

    /// Pumps until [finder] matches, up to [timeout].
    ///
    /// The software-rendered CI emulator can take noticeably longer than a
    /// fixed frame count to finish a first paint (shader compilation, a cold
    /// JIT, a slow raster thread), and a fixed `settle()` has no way to tell
    /// "still building" apart from "never going to appear". Dumps the tree
    /// on a genuine timeout, so a failure that reaches the tap below explains
    /// what was on screen instead of only that the finder found nothing.
    Future<void> waitFor(
      Finder finder, {
      Duration timeout = const Duration(seconds: 15),
    }) async {
      final deadline = DateTime.now().add(timeout);

      while (finder.evaluate().isEmpty) {
        if (DateTime.now().isAfter(deadline)) {
          final restore = debugPrint;
          debugPrint = debugPrintSynchronously;
          debugPrint('waitFor timed out after $timeout waiting for $finder');
          debugDumpApp();
          debugPrint = restore;

          return;
        }

        await tester.pump(const Duration(milliseconds: 100));
      }
    }

    /// Waits for [finder], taps it, then settles.
    Future<void> tapWhenReady(Finder finder) async {
      await waitFor(finder);
      await tester.tap(finder);
      await settle();
    }

    // Both preferences are read once, when the ProviderScope below first
    // builds, so they are set before every remount rather than changed on
    // the running app: the theme was already pinned this way, and the
    // language needs the same treatment, or the screenshots depend on
    // whichever locale the capturing machine happens to run.
    for (final language in _locales) {
      await sharedPreferences.setString(
        SharedPreferencesKeys.themeKey,
        ThemeMode.light.name,
      );
      await sharedPreferences.setString(
        SharedPreferencesKeys.languageKey,
        language,
      );

      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          adsEnabledProvider.overrideWithValue(false),
          deepLinkSourceProvider.overrideWithValue(_NoLinksSource()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const FlutterGuideApp(),
        ),
      );

      await settle();

      debugPrint(
        'main navigation index at startup: '
        '${container.read(mainNavigationNotifierProvider)}',
      );

      Future<void> shoot(String name) async {
        await settle();
        await binding.takeScreenshot('$language/$name');
      }

      Future<void> goBack() async {
        await tapWhenReady(find.byType(BackButtonWidget));
      }

      Future<void> tapNavIcon(IconData icon) async {
        await tapWhenReady(
          find.descendant(
            of: find.byType(NavigationBarWidget),
            matching: find.byIcon(icon),
          ),
        );
      }

      final context = tester.element(find.byType(Scaffold).first);
      final l10n = AppLocalizations.of(context);

      await shoot('01_home');

      await tapWhenReady(
        find.widgetWithText(BorderListTileItemWidget, l10n.elements),
      );
      await shoot('02_catalog_elements');
      await goBack();

      await tapWhenReady(
        find.widgetWithText(BorderListTileItemWidget, 'UIs'),
      );
      await shoot('03_catalog_uis');
      await goBack();

      await tapNavIcon(Icons.widgets_outlined);
      await shoot('04_elements_tab');

      await tapWhenReady(find.byType(CardWidget).first);
      await shoot('05_component_detail');

      await tapWhenReady(find.text(l10n.code));
      await shoot('06_component_code');
      await goBack();

      await tapNavIcon(Icons.archive_outlined);
      await shoot('07_packages_tab');

      await tapNavIcon(Icons.settings_outlined);
      await shoot('08_settings');

      await tapWhenReady(find.text(l10n.codeTheme));
      await shoot('09_code_theme_selector');
    }
  });
}
