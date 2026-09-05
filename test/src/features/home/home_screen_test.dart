import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/floating_bar_clearance_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/navigation/floating_bar_clearance_notifier.dart';
import 'package:flutter_guide/src/features/home/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/pump_app.dart';

/// A [FloatingBarClearanceNotifier] that starts already measured.
class _ClearanceOf extends FloatingBarClearanceNotifier {
  _ClearanceOf(this.value);

  final double value;

  @override
  double build() => value;
}

void main() {
  testWidgets('renders the entry points and component groups', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          adsEnabledProvider.overrideWithValue(false),
        ],
        child: const HomeScreen(),
      ),
    );

    final context = tester.element(find.byType(HomeScreen));
    final l10n = AppLocalizations.of(context);

    expect(find.text(l10n.elements), findsOneWidget);
    expect(find.text('UIs'), findsOneWidget);
    expect(find.text(l10n.components), findsOneWidget);
  });

  testWidgets('reserves space for the floating bottom bar at the list end', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        adsEnabledProvider.overrideWithValue(false),
        floatingBarClearanceProvider.overrideWith(() => _ClearanceOf(84)),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpApp(
      UncontrolledProviderScope(
        container: container,
        child: const HomeScreen(),
      ),
    );

    // The trailing SizedBox sits past the visible viewport in a list this
    // long, so it is not built until the list is scrolled to its end.
    final scrollable = tester.state<ScrollableState>(
      find.byType(Scrollable).first,
    );
    scrollable.position.jumpTo(scrollable.position.maxScrollExtent);
    await tester.pump();

    final sizedBoxes = tester
        .widgetList<SizedBox>(find.byType(SizedBox))
        .where((box) => box.height == 84);

    expect(sizedBoxes, hasLength(1));
  });
}
