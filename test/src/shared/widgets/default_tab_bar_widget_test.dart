import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/widgets/default_tab_bar_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(body: child),
        ),
      );

  group('DefaultTabBarWidget', () {
    testWidgets('renders the given tabs', (tester) async {
      await tester.pumpWidget(
        wrap(
          DefaultTabBarWidget(
            onTap: (_) {},
            tabs: const [Tab(text: 'One'), Tab(text: 'Two')],
          ),
        ),
      );

      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
    });

    testWidgets('reports the tapped tab index', (tester) async {
      int? tapped;
      await tester.pumpWidget(
        wrap(
          DefaultTabBarWidget(
            onTap: (value) => tapped = value,
            tabs: const [Tab(text: 'One'), Tab(text: 'Two')],
          ),
        ),
      );

      await tester.tap(find.text('Two'));

      expect(tapped, 1);
    });

    test('preferredSize matches the toolbar height', () {
      final widget = DefaultTabBarWidget(onTap: (_) {}, tabs: const []);

      expect(widget.preferredSize.height, kToolbarHeight);
    });
  });
}
