/// Builds the path to a sample's source file.
String resolveSampleFilePath({
  required String folder,
  required String fileName,
}) {
  return 'lib/src/features/catalog/data/samples/sample_components/'
      '$folder/${fileName}_sample.dart';
}
