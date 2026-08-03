import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url_error_dialog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('renders the error title and the url', (tester) async {
    const url = 'https://example.com';

    await tester.pumpApp(const OpenUrlErrorDialog(url: url));

    final context = tester.element(find.byType(OpenUrlErrorDialog));
    final l10n = AppLocalizations.of(context)!;

    expect(find.text(l10n.error), findsOneWidget);
    expect(
      find.textContaining(url, findRichText: true),
      findsOneWidget,
    );
  });

  testWidgets('closes the dialog when the Ok button is tapped', (
    tester,
  ) async {
    const url = 'https://example.com';

    await tester.pumpApp(
      Builder(
        builder: (context) {
          return ElevatedButton(
            onPressed: () {
              unawaited(
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return const OpenUrlErrorDialog(url: url);
                  },
                ),
              );
            },
            child: const Text('Open'),
          );
        },
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(OpenUrlErrorDialog), findsOneWidget);

    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();

    expect(find.byType(OpenUrlErrorDialog), findsNothing);
  });
}
