import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/router/app_router.dart';
import 'package:flutter_guide/src/features/settings/data/providers/app_version_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Test extensions for driving the app's production router.
extension PumpRouterApp on WidgetTester {
  /// Pumps the router from [appRouterProvider] at [location], inside a fresh
  /// [ProviderContainer] built for this call.
  ///
  /// Every repository provider derives from `sharedPreferencesProvider`, so
  /// mock prefs plus a stubbed app version are enough to render any route.
  /// Ads are disabled so no route reaches the real ad SDK; with them off,
  /// `BannerAdWidget` never reads `appEnvProvider`.
  ///
  /// Returns the container, so a test can read [appRouterProvider] itself
  /// afterward: to navigate imperatively, or to assert on the current
  /// location. The container is disposed automatically, unlike the static
  /// singleton this replaced, so nothing needs resetting between tests.
  Future<ProviderContainer> pumpRouterApp({
    required SharedPreferences prefs,
    String location = '/',
    String appVersion = '1.0.0+1',
  }) async {
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        adsEnabledProvider.overrideWithValue(false),
        appVersionRepositoryProvider.overrideWithValue(
          () async => appVersion,
        ),
      ],
    );
    addTearDown(container.dispose);

    final router = container.read(appRouterProvider)..go(location);

    await pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await pump();

    return container;
  }
}

/// The location [router] currently sits at.
///
/// Only reflects declarative navigation: an imperative `push` leaves this
/// unchanged, so assert on the rendered screen when testing a push.
String currentRouterLocation(GoRouter router) {
  return router.routerDelegate.currentConfiguration.uri.toString();
}

/// Creates a fresh mock [SharedPreferences] instance for a test.
Future<SharedPreferences> createMockPrefs([
  Map<String, Object> initialValues = const <String, Object>{},
]) async {
  SharedPreferences.setMockInitialValues(initialValues);

  return SharedPreferences.getInstance();
}
