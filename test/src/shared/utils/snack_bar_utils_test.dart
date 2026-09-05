import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/utils/snack_bar_utils.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('SnackBarUtils.show', () {
    testWidgets('shows a snack bar with the given text and Ok action', (
      tester,
    ) async {
      late BuildContext capturedContext;

      await tester.pumpApp(
        Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox.shrink();
          },
        ),
      );

      SnackBarUtils.show(capturedContext, 'Some message');
      await tester.pump();

      expect(find.text('Some message'), findsOneWidget);
      expect(find.text('Ok'), findsOneWidget);
    });
  });

  group('SnackBarUtils.showByKey', () {
    testWidgets('shows a snack bar via the messenger key with a custom '
        'label', (tester) async {
      final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

      await tester.pumpWidget(
        MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          home: const Scaffold(),
        ),
      );

      SnackBarUtils.showByKey(scaffoldMessengerKey, 'Key message', 'Got it');
      await tester.pump();

      expect(find.text('Key message'), findsOneWidget);
      expect(find.text('Got it'), findsOneWidget);
    });

    testWidgets('does nothing when the messenger key has no current state', (
      tester,
    ) async {
      final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

      SnackBarUtils.showByKey(scaffoldMessengerKey, 'Message', 'Ok');

      expect(find.text('Message'), findsNothing);
    });
  });
}
