import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/config/app_env.dart';
import 'package:flutter_guide/src/core/config/app_env_providers.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/shared/widgets/banner_ad_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_app_env.dart';
import '../../../helpers/pump_app.dart';

Future<void> _pumpBanner(
  WidgetTester tester, {
  required bool adsEnabled,
  AppEnv env = const FakeAppEnv(),
}) {
  return tester.pumpApp(
    ProviderScope(
      overrides: [
        adsEnabledProvider.overrideWithValue(adsEnabled),
        appEnvProvider.overrideWithValue(env),
      ],
      child: const BannerAdWidget(),
    ),
  );
}

void main() {
  group('BannerAdWidget', () {
    testWidgets('renders nothing when ads are disabled', (tester) async {
      await _pumpBanner(tester, adsEnabled: false);

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('renders nothing when no ad unit id is configured', (
      tester,
    ) async {
      // A clone with no .env reaches here. Before the environment contract,
      // the missing key threw out of initState instead.
      await _pumpBanner(tester, adsEnabled: true);

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('does not read the environment when ads are disabled', (
      tester,
    ) async {
      await tester.pumpApp(
        ProviderScope(
          overrides: [adsEnabledProvider.overrideWithValue(false)],
          child: const BannerAdWidget(),
        ),
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'shows the loading placeholder while a configured ad loads',
      (tester) async {
        // There is no real ad SDK in a widget test, so the request the
        // widget fires never resolves: this only proves the widget builds
        // the ad and attaches its listener without crashing, and renders
        // the same placeholder it would show a slow real network the
        // loading state before onAdLoaded ever fires.
        await _pumpBanner(
          tester,
          adsEnabled: true,
          env: const FakeAppEnv(
            bannerAdUnitId: 'ca-app-pub-3940256099942544/6300978111',
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // The widget disposes its ad on unmount without rethrowing whatever
        // the platform channel returned for a load that never completed.
        await tester.pumpApp(const SizedBox.shrink());

        expect(tester.takeException(), isNull);
      },
    );
  });
}
