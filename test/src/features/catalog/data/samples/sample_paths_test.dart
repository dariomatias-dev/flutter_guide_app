import 'package:flutter_guide/src/features/catalog/data/samples/sample_paths.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resolveSampleFilePath builds path from folder and fileName', () {
    final path = resolveSampleFilePath(
      folder: 'widgets',
      fileName: 'card',
    );

    expect(
      path,
      'lib/src/features/catalog/data/samples/sample_components/'
      'widgets/card_sample.dart',
    );
  });
}
