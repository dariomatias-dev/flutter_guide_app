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
}
