import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/shell/widgets/bottom_navigation_bar/navigation_bar_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/pump_app.dart';

const _tabNames = <String>['Home', 'Elements', 'Packages', 'Settings'];
const _lastIndex = 3;

void main() {
  late List<int> requestedIndices;

  setUp(() {
    requestedIndices = <int>[];
  });

  Future<void> pumpBar(WidgetTester tester, {required int screenIndex}) {
    return tester.pumpApp(
      NavigationBarWidget(
        screenIndex: screenIndex,
        updateScreenIndex: requestedIndices.add,
        getBottomNavigationBarName: (index) => _tabNames[index],
      ),
    );
  }

  /// Flings horizontally with [velocity] px/s: negative swipes left.
  Future<void> swipe(WidgetTester tester, double velocity) async {
    await tester.fling(
      find.byType(NavigationBarWidget),
      Offset(velocity.isNegative ? -50 : 50, 0),
      velocity.abs(),
    );
    await tester.pumpAndSettle();
  }

  group('NavigationBarWidget', () {
    testWidgets('renders every tab label', (tester) async {
      await pumpBar(tester, screenIndex: 0);

      for (final name in _tabNames) {
        expect(find.text(name), findsWidgets, reason: '$name is missing');
      }
    });

    testWidgets('reports the tapped tab', (tester) async {
      await pumpBar(tester, screenIndex: 0);

      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pump();

      expect(requestedIndices, <int>[_lastIndex]);
    });
  });

  group('NavigationBarWidget swipe', () {
    testWidgets('a left swipe advances to the next tab', (tester) async {
      await pumpBar(tester, screenIndex: 0);

      await swipe(tester, -1000);

      expect(requestedIndices, <int>[1]);
    });

    testWidgets('a right swipe goes back to the previous tab', (tester) async {
      await pumpBar(tester, screenIndex: 2);

      await swipe(tester, 1000);

      expect(requestedIndices, <int>[1]);
    });

    testWidgets('a left swipe on the last tab is ignored', (tester) async {
      await pumpBar(tester, screenIndex: _lastIndex);

      await swipe(tester, -1000);

      expect(requestedIndices, isEmpty);
    });

    testWidgets('a right swipe on the first tab is ignored', (tester) async {
      await pumpBar(tester, screenIndex: 0);

      await swipe(tester, 1000);

      expect(requestedIndices, isEmpty);
    });

    testWidgets('a swipe below the velocity threshold is ignored', (
      tester,
    ) async {
      await pumpBar(tester, screenIndex: 1);

      // The handler only reacts past 100 px/s in either direction.
      await swipe(tester, -50);
      await swipe(tester, 50);

      expect(requestedIndices, isEmpty);
    });
  });
}
