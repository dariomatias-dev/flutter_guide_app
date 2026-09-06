import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/shell/widgets/bottom_navigation_bar/navigation_bar_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/pump_app.dart';

const _tabNames = <String>['Home', 'Elements', 'Packages', 'Settings'];
const _lastIndex = 3;

/// The Portuguese (BR) tab labels: the longest across the app's three
/// supported locales, and the ones that overflowed the bar on a real device
/// in production despite every widget test passing at the default,
/// desktop-sized test viewport.
const _longestTabNames = <String>[
  'Início',
  'Elementos',
  'Pacotes',
  'Configurações',
];

/// A narrow phone's logical width, the tightest fit the app is expected to
/// render on.
const _narrowLogicalWidth = 320.0;
const _devicePixelRatio = 2.0;

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

  group('NavigationBarWidget on a narrow phone', () {
    testWidgets('never overflows selecting the longest label per tab', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(
        _narrowLogicalWidth * _devicePixelRatio,
        1280,
      );
      tester.view.devicePixelRatio = _devicePixelRatio;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                Positioned(
                  right: 16,
                  left: 16,
                  bottom: 8,
                  child: SafeArea(
                    child: NavigationBarWidget(
                      screenIndex: 0,
                      updateScreenIndex: requestedIndices.add,
                      getBottomNavigationBarName: (index) =>
                          _longestTabNames[index],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      for (final icon in const [
        Icons.widgets_outlined,
        Icons.archive_outlined,
        Icons.settings_outlined,
        Icons.home_outlined,
      ]) {
        await tester.tap(find.byIcon(icon));
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      }
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
