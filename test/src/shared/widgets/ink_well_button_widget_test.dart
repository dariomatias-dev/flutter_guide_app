import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/widgets/ink_well_button_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('InkWellButtonWidget', () {
    testWidgets('renders its child', (tester) async {
      await tester.pumpWidget(
        wrap(
          const InkWellButtonWidget(
            borderRadius: 8,
            child: Text('label'),
          ),
        ),
      );

      expect(find.text('label'), findsOneWidget);
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        wrap(
          InkWellButtonWidget(
            borderRadius: 8,
            onTap: () => taps++,
            child: const Text('tap'),
          ),
        ),
      );

      await tester.tap(find.text('tap'));

      expect(taps, 1);
    });

    testWidgets('applies the background color', (tester) async {
      await tester.pumpWidget(
        wrap(
          const InkWellButtonWidget(
            borderRadius: 8,
            backgroundColor: Color(0xFF00FF00),
            child: SizedBox(width: 10, height: 10),
          ),
        ),
      );

      final ink = tester.widget<Ink>(find.byType(Ink));
      final decoration = ink.decoration! as BoxDecoration;
      expect(decoration.color, const Color(0xFF00FF00));
    });
  });
}
