import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('IconButtonWidget', () {
    testWidgets('renders the given icon', (tester) async {
      await tester.pumpWidget(
        wrap(
          IconButtonWidget(
            icon: Icons.star,
            onTap: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders a custom child instead of an icon', (tester) async {
      await tester.pumpWidget(
        wrap(
          IconButtonWidget(
            onTap: () {},
            child: const Text('custom'),
          ),
        ),
      );

      expect(find.text('custom'), findsOneWidget);
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        wrap(
          IconButtonWidget(
            icon: Icons.star,
            onTap: () => taps++,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.star));

      expect(taps, 1);
    });

    test('asserts when both icon and child are provided', () {
      expect(
        () => IconButtonWidget(
          icon: Icons.star,
          onTap: () {},
          child: const Text('x'),
        ),
        throwsAssertionError,
      );
    });
  });
}
