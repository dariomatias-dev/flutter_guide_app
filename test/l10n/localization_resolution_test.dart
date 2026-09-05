import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Future<AppLocalizations> _localizationsFor(
  WidgetTester tester,
  Locale locale,
) async {
  late AppLocalizations localizations;

  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Builder(
        builder: (context) {
          localizations = AppLocalizations.of(context)!;

          return const SizedBox.shrink();
        },
      ),
    ),
  );

  return localizations;
}

void main() {
  group('locale resolution', () {
    testWidgets('resolves Portuguese for a pt-BR device', (tester) async {
      final localizations = await _localizationsFor(
        tester,
        const Locale('pt', 'BR'),
      );

      expect(localizations.localeName, 'pt');
      expect(localizations.settings, 'Configurações');
    });

    testWidgets('resolves Portuguese for a pt-PT device', (tester) async {
      final localizations = await _localizationsFor(
        tester,
        const Locale('pt', 'PT'),
      );

      expect(localizations.localeName, 'pt');
      expect(localizations.settings, 'Configurações');
    });

    testWidgets('resolves Spanish for an es device', (tester) async {
      final localizations = await _localizationsFor(
        tester,
        const Locale('es'),
      );

      expect(localizations.localeName, 'es');
    });

    testWidgets('falls back to English for an unsupported device', (
      tester,
    ) async {
      final localizations = await _localizationsFor(
        tester,
        const Locale('fr'),
      );

      expect(localizations.localeName, 'en');
    });
  });
}
