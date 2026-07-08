import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('ListTileItemWidget', () {
    testWidgets('renders the title', (tester) async {
      await tester.pumpWidget(wrap(const ListTileItemWidget(title: 'Row')));

      expect(find.text('Row'), findsOneWidget);
    });

    testWidgets('renders the leading icon when provided', (tester) async {
      await tester.pumpWidget(
        wrap(const ListTileItemWidget(title: 'Row', icon: Icons.home)),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('shows the open-in-browser icon when enabled', (tester) async {
      await tester.pumpWidget(
        wrap(const ListTileItemWidget(title: 'Row', openInBrowser: true)),
      );

      expect(find.byIcon(Icons.open_in_new_rounded), findsOneWidget);
    });

    testWidgets('hides the open-in-browser icon by default', (tester) async {
      await tester.pumpWidget(wrap(const ListTileItemWidget(title: 'Row')));

      expect(find.byIcon(Icons.open_in_new_rounded), findsNothing);
    });

    testWidgets('renders the trailing widgets', (tester) async {
      await tester.pumpWidget(
        wrap(
          const ListTileItemWidget(
            title: 'Row',
            trailingWidgets: [Text('trail')],
          ),
        ),
      );

      expect(find.text('trail'), findsOneWidget);
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        wrap(ListTileItemWidget(title: 'Row', onTap: () => taps++)),
      );

      await tester.tap(find.text('Row'));

      expect(taps, 1);
    });
  });
}
