import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/widgets/app_failure_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final english = lookupAppLocalizations(const Locale('en'));

  group('AppFailureScreen', () {
    testWidgets('describes a startup failure and offers a retry', (
      tester,
    ) async {
      var retries = 0;

      // Pumped bare: the screen runs where there is no MaterialApp, so it has
      // to stand up without an ancestor theme, direction or localization.
      await tester.pumpWidget(
        AppFailureScreen(
          kind: AppFailureKind.startup,
          onRetry: () => retries++,
        ),
      );

      expect(find.text(english.startupErrorTitle), findsOneWidget);
      expect(find.text(english.startupErrorMessage), findsOneWidget);

      await tester.tap(find.text(english.retry));

      expect(retries, 1);
    });

    testWidgets('shows no retry action when none is given', (tester) async {
      await tester.pumpWidget(
        const AppFailureScreen(kind: AppFailureKind.unexpected),
      );

      expect(find.text(english.unexpectedErrorTitle), findsOneWidget);
      expect(find.text(english.retry), findsNothing);
    });

    testWidgets('falls back to English for an unsupported device locale', (
      tester,
    ) async {
      // lookupAppLocalizations throws on an unsupported locale, which on the
      // screen that exists to report a failure would replace it with another.
      tester.platformDispatcher.localeTestValue = const Locale('ja');
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);

      await tester.pumpWidget(
        const AppFailureScreen(kind: AppFailureKind.startup),
      );

      expect(find.text(english.startupErrorTitle), findsOneWidget);
    });

    testWidgets('uses the device language when it is supported', (
      tester,
    ) async {
      tester.platformDispatcher.localeTestValue = const Locale('pt', 'BR');
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);

      final portuguese = lookupAppLocalizations(const Locale('pt'));

      await tester.pumpWidget(
        const AppFailureScreen(kind: AppFailureKind.startup),
      );

      expect(find.text(portuguese.startupErrorTitle), findsOneWidget);
    });

    testWidgets('shows the technical details in a debug build', (tester) async {
      await tester.pumpWidget(
        const AppFailureScreen(
          kind: AppFailureKind.startup,
          technicalDetails: 'FileNotFoundError: .env',
        ),
      );

      expect(find.text('FileNotFoundError: .env'), findsOneWidget);
    });

    testWidgets('uses the dark theme when the platform is dark', (
      tester,
    ) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(
        tester.platformDispatcher.clearPlatformBrightnessTestValue,
      );

      await tester.pumpWidget(
        const AppFailureScreen(kind: AppFailureKind.startup),
      );

      final material = tester.widget<Material>(find.byType(Material));

      expect(material.color, isNot(Colors.white));
    });
  });
}
