import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_button_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('DialogButtonWidget', () {
    testWidgets('renders the label', (tester) async {
      await tester.pumpWidget(
        wrap(DialogButtonWidget(text: 'OK', onTap: () {})),
      );

      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        wrap(DialogButtonWidget(text: 'OK', onTap: () => taps++)),
      );

      await tester.tap(find.text('OK'));

      expect(taps, 1);
    });

    testWidgets('applies the custom background color', (tester) async {
      await tester.pumpWidget(
        wrap(
          DialogButtonWidget(
            text: 'OK',
            onTap: () {},
            backgroundColor: const Color(0xFF123456),
          ),
        ),
      );

      final ink = tester.widget<Ink>(find.byType(Ink));
      final decoration = ink.decoration! as BoxDecoration;
      expect(decoration.color, const Color(0xFF123456));
    });
  });
}
