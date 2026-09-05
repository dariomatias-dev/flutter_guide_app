import 'package:flutter_guide/src/core/errors/error_reporter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';

void main() {
  late Logger logger;
  late LoggerErrorReporter reporter;

  setUp(() {
    logger = MockLogger();
    reporter = LoggerErrorReporter(logger);
  });

  group('LoggerErrorReporter', () {
    test('logs the error, the stack trace and the context', () {
      final error = StateError('boom');
      final stackTrace = StackTrace.current;

      reporter.report(error, stackTrace, context: 'Startup failed');

      verify(
        () => logger.e(
          'Startup failed',
          error: error,
          stackTrace: stackTrace,
        ),
      ).called(1);
    });

    test('names the report when no context is given', () {
      final stackTrace = StackTrace.current;

      reporter.report('boom', stackTrace);

      verify(
        () => logger.e(
          'Unhandled error',
          error: 'boom',
          stackTrace: stackTrace,
        ),
      ).called(1);
    });
  });
}
