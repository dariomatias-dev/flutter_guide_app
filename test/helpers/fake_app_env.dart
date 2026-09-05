import 'package:flutter_guide/src/core/config/app_env.dart';

/// [AppEnv] with values set by the test.
///
/// Defaults to an unconfigured environment, which is what a clone without an
/// `.env` file gets.
class FakeAppEnv implements AppEnv {
  /// Creates a [FakeAppEnv].
  const FakeAppEnv({
    this.bannerAdUnitId,
    this.testDeviceIds = const <String>[],
  });

  @override
  final String? bannerAdUnitId;

  @override
  final List<String> testDeviceIds;
}
