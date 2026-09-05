import 'package:logger/logger.dart';

/// Records a failure that reached the app's outermost boundary, where no
/// other code was left to handle it.
///
/// A contract rather than a function, so a test can assert what was reported
/// and the app can gain a second destination without touching a call site.
// ignore: one_member_abstracts
abstract interface class ErrorReporter {
  /// Records [error] and its [stackTrace], with an optional [context] naming
  /// what the app was doing when it failed.
  void report(Object error, StackTrace stackTrace, {String? context});
}

/// [ErrorReporter] writing through the app's `Logger`.
///
/// The app ships without a crash reporting backend, so the device log is
/// where an otherwise invisible release failure can still be read back from.
class LoggerErrorReporter implements ErrorReporter {
  /// Creates a [LoggerErrorReporter] writing to the given logger.
  const LoggerErrorReporter(this._logger);

  final Logger _logger;

  @override
  void report(Object error, StackTrace stackTrace, {String? context}) {
    _logger.e(
      context ?? 'Unhandled error',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
