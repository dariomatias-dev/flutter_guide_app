import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

/// Driver entrypoint for `flutter drive`. Receives each screenshot taken
/// by `integration_test/screenshot_test.dart` and writes it to
/// `screenshots/`.
Future<void> main() async {
  await integrationDriver(
    onScreenshot: (name, bytes, [args]) async {
      final file = File('screenshots/$name.png');
      await file.create(recursive: true);
      await file.writeAsBytes(bytes);

      return true;
    },
  );
}
