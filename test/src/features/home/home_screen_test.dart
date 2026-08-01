import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/features/home/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('renders the entry points and component groups', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          adsEnabledProvider.overrideWithValue(false),
        ],
        child: const HomeScreen(),
      ),
    );

    final context = tester.element(find.byType(HomeScreen));
    final l10n = AppLocalizations.of(context)!;

    expect(find.text(l10n.elements), findsOneWidget);
    expect(find.text('UIs'), findsOneWidget);
    expect(find.text(l10n.components), findsOneWidget);
  });
}
