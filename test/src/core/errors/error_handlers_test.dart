import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_guide/src/core/errors/error_handlers.dart';
import 'package:flutter_guide/src/core/errors/error_reporter.dart';
import 'package:flutter_test/flutter_test.dart';

class _RecordingReporter implements ErrorReporter {
  final reports = <({Object error, String? context})>[];

  @override
  void report(Object error, StackTrace stackTrace, {String? context}) {
    reports.add((error: error, context: context));
  }
}

void main() {
  late _RecordingReporter reporter;
  late FlutterExceptionHandler? previousFlutterHandler;
  late ErrorCallback? previousPlatformHandler;

  setUp(() {
    reporter = _RecordingReporter();
    previousFlutterHandler = FlutterError.onError;
    previousPlatformHandler = PlatformDispatcher.instance.onError;
  });

  tearDown(() {
    FlutterError.onError = previousFlutterHandler;
    PlatformDispatcher.instance.onError = previousPlatformHandler;
  });

  group('installErrorHandlers', () {
    test('reports a framework error and still presents it', () {
      installErrorHandlers(reporter);

      final presented = <FlutterErrorDetails>[];
      final previousPresent = FlutterError.presentError;
      FlutterError.presentError = presented.add;
      addTearDown(() => FlutterError.presentError = previousPresent);

      FlutterError.reportError(
        FlutterErrorDetails(
          exception: StateError('boom'),
          stack: StackTrace.current,
          context: ErrorDescription('while testing'),
        ),
      );

      expect(reporter.reports, hasLength(1));
      expect(reporter.reports.single.error, isStateError);
      expect(reporter.reports.single.context, contains('while testing'));
      expect(presented, hasLength(1));
    });

    test('fills in a stack trace when the details carry none', () {
      installErrorHandlers(reporter);

      final previousPresent = FlutterError.presentError;
      FlutterError.presentError = (_) {};
      addTearDown(() => FlutterError.presentError = previousPresent);

      FlutterError.reportError(
        FlutterErrorDetails(exception: StateError('no stack')),
      );

      expect(reporter.reports, hasLength(1));
    });

    test('reports an uncaught platform error and treats it as handled', () {
      installErrorHandlers(reporter);

      // Returning false instead would let the failure tear the isolate down,
      // closing the app on the user.
      final handled = PlatformDispatcher.instance.onError!(
        StateError('async boom'),
        StackTrace.current,
      );

      expect(handled, isTrue);
      expect(reporter.reports.single.context, 'Uncaught platform error');
    });
  });
}
