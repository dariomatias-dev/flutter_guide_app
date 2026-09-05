import 'package:flutter_guide/src/core/di/logger_provider.dart';
import 'package:flutter_guide/src/core/errors/error_reporter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

void main() {
  group('logger providers', () {
    test('exposes one logger for the whole graph', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(loggerProvider), isA<Logger>());
      expect(
        container.read(loggerProvider),
        same(container.read(loggerProvider)),
      );
    });

    test('builds the reporter on the same logger', () {
      final logger = Logger();
      addTearDown(logger.close);

      final container = ProviderContainer(
        overrides: [loggerProvider.overrideWithValue(logger)],
      );
      addTearDown(container.dispose);

      expect(container.read(errorReporterProvider), isA<LoggerErrorReporter>());
    });
  });
}
