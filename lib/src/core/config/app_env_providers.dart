import 'package:flutter_guide/src/core/config/app_env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The app's environment configuration.
///
/// Declared without a value and overridden in `main.dart` with the instance
/// startup already loaded, so nothing downstream has to await it. Tests
/// override it with a fake.
final appEnvProvider = Provider<AppEnv>((ref) {
  throw UnimplementedError('appEnvProvider must be overridden');
});
