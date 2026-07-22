import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/core/shell/widgets/bottom_navigation_bar/navigation_bar_widget.dart';
import 'package:flutter_guide/src/features/home/widgets/border_list_tile_item_widget.dart';
import 'package:flutter_guide/src/flutter_guide_app.dart';
import 'package:flutter_guide/src/shared/widgets/back_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Drives the app through its main screens, taking a screenshot of each,
/// so marketing assets (README, Play Store, website) can be generated
/// without manually navigating the app.
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
    await sharedPreferences.setString(
      SharedPreferencesKeys.themeKey,
      ThemeMode.light.name,
    );

    await binding.convertFlutterSurfaceToImage();

    /// `pumpAndSettle` never returns: a collapsed [BannerAdWidget] still
    /// builds its indeterminate progress indicator while the real ad
    /// loads, which keeps scheduling frames forever.
    Future<void> settle() async {
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          adsEnabledProvider.overrideWithValue(false),
        ],
        child: const FlutterGuideApp(),
      ),
    );

    await settle();

    Future<void> shoot(String name) async {
      await settle();
      await binding.takeScreenshot(name);
    }

    Future<void> goBack() async {
      await tester.tap(find.byType(BackButtonWidget));
      await settle();
    }

    Future<void> tapNavIcon(IconData icon) async {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBarWidget),
          matching: find.byIcon(icon),
        ),
      );
      await settle();
    }

    final context = tester.element(find.byType(Scaffold).first);
    final l10n = AppLocalizations.of(context)!;

    await shoot('01_home');

    await tester.tap(
      find.widgetWithText(BorderListTileItemWidget, l10n.elements),
    );
    await settle();
    await shoot('02_catalog_elements');
    await goBack();

    await tester.tap(find.widgetWithText(BorderListTileItemWidget, 'UIs'));
    await settle();
    await shoot('03_catalog_uis');
    await goBack();

    await tapNavIcon(Icons.widgets_outlined);
    await shoot('04_elements_tab');

    await tester.tap(find.byType(CardWidget).first);
    await settle();
    await shoot('05_component_detail');

    await tester.tap(find.text(l10n.code));
    await settle();
    await shoot('06_component_code');
    await goBack();

    await tapNavIcon(Icons.archive_outlined);
    await shoot('07_packages_tab');

    await tapNavIcon(Icons.settings_outlined);
    await shoot('08_settings');

    await tester.tap(find.text(l10n.codeTheme));
    await settle();
    await shoot('09_code_theme_selector');
  });
}
