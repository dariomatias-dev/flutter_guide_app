import 'package:flutter/foundation.dart';
import 'package:flutter_guide/src/core/errors/error_reporter.dart';

/// Routes the errors that reach the framework's outermost handlers into
/// [reporter].
///
/// Both handlers default to printing in debug builds and doing nothing else,
/// so without this a release build loses every failure no `catch` claimed: a
/// widget throwing during build leaves an error box and no trace, and an
/// error escaping a detached async callback disappears outright.
///
/// The platform handler treats reporting as handling. Returning `false`
/// instead would let a failure in a plugin's platform channel tear the
/// isolate down, closing the app on the user.
void installErrorHandlers(ErrorReporter reporter) {
  FlutterError.onError = (details) {
    reporter.report(
      details.exception,
      details.stack ?? StackTrace.current,
      context: details.context?.toStringDeep(),
    );

    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    reporter.report(error, stack, context: 'Uncaught platform error');

    return true;
  };
}
