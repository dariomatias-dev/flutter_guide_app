import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/router/app_router.dart';
import 'package:flutter_guide/src/core/router/route_paths.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/app_version_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Test extensions for driving the app's production router.
extension PumpRouterApp on WidgetTester {
  /// Pumps [AppRouter.router] at [location] inside a test-wired scope.
  ///
  /// Every repository provider derives from `sharedPreferencesProvider`, so
  /// mock prefs plus a stubbed app version are enough to render any route.
  /// Ads are disabled because `BannerAdWidget` needs a real dotenv.
  ///
  /// [AppRouter.router] is a singleton, so pair this with
  /// [resetRouterLocation] in a `tearDown`.
  Future<void> pumpRouterApp({
    required SharedPreferences prefs,
    String location = RoutePaths.root,
    String appVersion = '1.0.0+1',
  }) async {
    AppRouter.router.go(location);

    await pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          adsEnabledProvider.overrideWithValue(false),
          appVersionRepositoryProvider.overrideWithValue(
            () async => appVersion,
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: AppRouter.router,
        ),
      ),
    );
    await pump();
  }
}

/// The location [AppRouter.router] currently sits at.
///
/// Only reflects declarative navigation: an imperative `push` leaves this
/// unchanged, so assert on the rendered screen when testing a push.
String currentRouterLocation() {
  return AppRouter.router.routerDelegate.currentConfiguration.uri.toString();
}

/// Sends the shared router singleton back to the root location.
void resetRouterLocation() {
  AppRouter.router.go(RoutePaths.root);
}

/// Creates a fresh mock [SharedPreferences] instance for a test.
Future<SharedPreferences> createMockPrefs([
  Map<String, Object> initialValues = const <String, Object>{},
]) async {
  SharedPreferences.setMockInitialValues(initialValues);

  return SharedPreferences.getInstance();
}
