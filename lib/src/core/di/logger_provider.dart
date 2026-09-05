import 'package:flutter_guide/src/core/errors/error_reporter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// The app's logger.
///
/// A provider rather than a field on the root widget, so anything that needs
/// to report a failure reaches the same instance, and a test can replace it.
final loggerProvider = Provider<Logger>((ref) {
  final logger = Logger();
  ref.onDispose(logger.close);

  return logger;
});

/// Reports failures that reached the app's outermost boundary.
final errorReporterProvider = Provider<ErrorReporter>((ref) {
  return LoggerErrorReporter(ref.watch(loggerProvider));
});
