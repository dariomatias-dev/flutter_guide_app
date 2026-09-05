import 'package:flutter/material.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_screen_inherited_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ComponentSampleScreenInheritedWidget', () {
    testWidgets('of returns null when there is no ancestor', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;

              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(
        ComponentSampleScreenInheritedWidget.of(capturedContext),
        isNull,
      );
    });

    testWidgets('of returns the nearest ancestor', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: ComponentSampleScreenInheritedWidget(
            fileName: 'center_sample.dart',
            componentName: 'Center',
            child: Builder(
              builder: (context) {
                capturedContext = context;

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      final found = ComponentSampleScreenInheritedWidget.of(capturedContext);

      expect(found?.fileName, 'center_sample.dart');
      expect(found?.componentName, 'Center');
    });

    testWidgets('notifies dependants when the ancestor rebuilds', (
      tester,
    ) async {
      var dependantBuilds = 0;
      var fileName = 'center_sample.dart';

      Widget build() => MaterialApp(
        home: ComponentSampleScreenInheritedWidget(
          fileName: fileName,
          componentName: 'Center',
          child: Builder(
            builder: (context) {
              // Establishes the dependency updateShouldNotify reports on.
              ComponentSampleScreenInheritedWidget.of(context);
              dependantBuilds++;

              return const SizedBox.shrink();
            },
          ),
        ),
      );

      await tester.pumpWidget(build());
      expect(dependantBuilds, 1);

      fileName = 'row_sample.dart';
      await tester.pumpWidget(build());

      expect(dependantBuilds, 2);
    });
  });
}
