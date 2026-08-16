import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/flutter_guide_colors.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/component_sample_font_size_selector_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../helpers/pump_app.dart';

void main() {
  group('ComponentSampleFontSizeSelectorWidget', () {
    testWidgets('renders the given icon', (tester) async {
      await tester.pumpApp(
        const ComponentSampleFontSizeSelectorWidget(
          action: null,
          icon: Icons.add,
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('calls the action when tapped', (tester) async {
      var taps = 0;

      await tester.pumpApp(
        ComponentSampleFontSizeSelectorWidget(
          action: () => taps++,
          icon: Icons.remove,
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(taps, 1);
    });

    testWidgets('is disabled when the action is null', (tester) async {
      await tester.pumpApp(
        const ComponentSampleFontSizeSelectorWidget(
          action: null,
          icon: Icons.add,
        ),
      );

      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      expect(button.onPressed, isNull);
      expect(button.enabled, isFalse);
    });

    testWidgets('uses the light icon color under a light theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: const Scaffold(
            body: ComponentSampleFontSizeSelectorWidget(
              action: null,
              icon: Icons.add,
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.add));

      expect(icon.color, FlutterGuideColors.white);
    });

    testWidgets('uses the dark icon color under a dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: const Scaffold(
            body: ComponentSampleFontSizeSelectorWidget(
              action: null,
              icon: Icons.add,
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.add));

      expect(icon.color, FlutterGuideColors.darkNeutral);
    });
  });
}
