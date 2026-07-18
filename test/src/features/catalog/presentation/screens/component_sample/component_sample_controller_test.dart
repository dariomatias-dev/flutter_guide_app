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
}
