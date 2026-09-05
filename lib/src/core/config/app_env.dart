/// Read access to the app's environment configuration.
///
/// A missing key is a missing value, never an exception: the app has to start
/// and render even when a build was made without an `.env` file, which is the
/// case for a fresh clone and for CI.
abstract interface class AppEnv {
  /// The banner ad unit id, or `null` when it is not configured.
  String? get bannerAdUnitId;

  /// Device ids that receive test ads, empty when none are configured.
  List<String> get testDeviceIds;
}
