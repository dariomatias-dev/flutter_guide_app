import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('DialogWidget', () {
    testWidgets('renders title, description, body and actions', (tester) async {
      await tester.pumpWidget(
        wrap(
          const DialogWidget(
            title: 'Title',
            description: 'Description',
            actions: [Text('action')],
            children: [Text('body')],
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('body'), findsOneWidget);
      expect(find.text('action'), findsOneWidget);
    });

    testWidgets('omits the title when not provided', (tester) async {
      await tester.pumpWidget(
        wrap(const DialogWidget(description: 'Only description')),
      );

      expect(find.text('Only description'), findsOneWidget);
      expect(find.byType(Wrap), findsNothing);
    });

    testWidgets('renders no text when empty', (tester) async {
      await tester.pumpWidget(wrap(const DialogWidget()));

      expect(find.byType(Text), findsNothing);
    });
  });
}
