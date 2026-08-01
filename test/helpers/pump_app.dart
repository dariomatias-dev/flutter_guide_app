import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test extensions for pumping widgets inside the app's shell.
extension PumpApp on WidgetTester {
  /// Pumps [widget] inside a localized [MaterialApp].
  ///
  /// For widgets that read providers, pass a `ProviderScope` (with its
  /// overrides) as [widget] so it sits below the localization context.
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: widget),
      ),
    );
  }

  /// Pumps [child] inside a localized [MaterialApp], with [wrap] applied
  /// around the whole app instead of below it.
  ///
  /// Use this instead of [pumpApp] when [child] opens overlay content (popup
  /// menus, dialogs, snack bars) that must also see the `ProviderScope`
  /// passed via [wrap] — overlay routes attach to the app's root `Overlay`,
  /// which sits above anything nested only inside the `Scaffold` body.
  Future<void> pumpScopedApp(
    Widget Function(Widget app) wrap,
    Widget child,
  ) {
    return pumpWidget(
      wrap(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: child),
        ),
      ),
    );
  }
}
