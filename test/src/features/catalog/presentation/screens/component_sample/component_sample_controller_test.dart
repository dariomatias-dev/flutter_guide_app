import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_controller.dart';
import 'package:flutter_test/flutter_test.dart';

const _filePath = 'lib/src/features/catalog/data/samples/'
    'sample_components/widgets/paginateddatatable_sample.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<int> loadLineCount() async {
    final content = await rootBundle.loadString(_filePath);

    return content.split('\n').length;
  }

  group('ComponentSampleController', () {
    testWidgets('loads the source and reports its line count', (
      tester,
    ) async {
      final controller = ComponentSampleController(
        vsync: tester,
        filePath: _filePath,
      );
      addTearDown(controller.dispose);

      final expectedLineCount = await loadLineCount();
      await tester.pumpAndSettle();

      expect(controller.lineCountNotifier.value, expectedLineCount);
    });

    testWidgets('splits the source into chunks of up to 50 lines', (
      tester,
    ) async {
      final controller = ComponentSampleController(
        vsync: tester,
        filePath: _filePath,
      );
      addTearDown(controller.dispose);

      await tester.pumpAndSettle();

      final lineCount = controller.lineCountNotifier.value;
      final expectedChunkCount = (lineCount / 50).ceil();

      for (var i = 0; i < expectedChunkCount; i++) {
        final chunk = controller.getChunck(i);
        final isLastChunk = i == expectedChunkCount - 1;
        final expectedLength = isLastChunk ? lineCount - (50 * i) : 50;

        expect(chunk, hasLength(expectedLength));
      }
    });

    testWidgets('returns an empty chunk when the index is out of range', (
      tester,
    ) async {
      final controller = ComponentSampleController(
        vsync: tester,
        filePath: _filePath,
      );
      addTearDown(controller.dispose);

      await tester.pumpAndSettle();

      expect(controller.getChunck(-1), isEmpty);
      expect(controller.getChunck(999), isEmpty);
    });

    testWidgets('dispose can be called without throwing', (tester) async {
      final controller = ComponentSampleController(
        vsync: tester,
        filePath: _filePath,
      );

      await tester.pumpAndSettle();

      expect(controller.dispose, returnsNormally);
    });
  });

  group('ComponentSampleController tab changes', () {
    /// Builds a controller with its page controller attached to a page view.
    ///
    /// `_tabOnChange` animates the page controller, which throws unless it
    /// has a client.
    Future<ComponentSampleController> pumpController(
      WidgetTester tester,
    ) async {
      final controller = ComponentSampleController(
        vsync: tester,
        filePath: _filePath,
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PageView(
              controller: controller.pageController,
              children: const <Widget>[
                SizedBox(key: Key('preview')),
                SizedBox(key: Key('code')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      return controller;
    }

    testWidgets('starts on the first tab with the actions hidden', (
      tester,
    ) async {
      final controller = await pumpController(tester);

      expect(controller.currentTabIndexNotifier.value, 0);
      expect(controller.showFloatingActionsNotifier.value, isFalse);
      expect(controller.tabController.index, 0);
    });

    testWidgets('reveals the actions on the code tab', (tester) async {
      final controller = await pumpController(tester);

      controller.currentTabIndexNotifier.value = 1;
      await tester.pumpAndSettle();

      expect(controller.showFloatingActionsNotifier.value, isTrue);
      expect(controller.tabController.index, 1);
    });

    testWidgets('hides the actions again on the preview tab', (tester) async {
      final controller = await pumpController(tester);

      controller.currentTabIndexNotifier.value = 1;
      await tester.pumpAndSettle();

      controller.currentTabIndexNotifier.value = 0;
      await tester.pumpAndSettle();

      expect(controller.showFloatingActionsNotifier.value, isFalse);
      expect(controller.tabController.index, 0);
    });

    testWidgets('animates the page view to the selected tab', (tester) async {
      final controller = await pumpController(tester);

      controller.currentTabIndexNotifier.value = 1;
      await tester.pumpAndSettle();

      expect(controller.pageController.page, 1);
    });

    testWidgets('starts the font size midway between the bounds', (
      tester,
    ) async {
      final controller = await pumpController(tester);

      expect(
        controller.fontSizeNotifier.value,
        greaterThan(ComponentSampleController.minFontSize),
      );
      expect(
        controller.fontSizeNotifier.value,
        lessThan(ComponentSampleController.maxFontSize),
      );
    });
  });
}
