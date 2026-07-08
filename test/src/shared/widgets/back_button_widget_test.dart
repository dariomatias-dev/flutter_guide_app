import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/widgets/back_button_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BackButtonWidget', () {
    testWidgets('renders the back icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BackButtonWidget()),
        ),
      );

      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });

    testWidgets('pops the current route when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const Scaffold(body: BackButtonWidget()),
                  ),
                ),
                child: const Text('go'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      await tester.pumpAndSettle();

      expect(find.text('go'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new), findsNothing);
    });
  });
}
