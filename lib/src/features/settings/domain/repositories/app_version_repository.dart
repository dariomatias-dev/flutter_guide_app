/// Provides the running app's version.
abstract class AppVersionRepository {
  /// Returns the app version string (e.g. `1.2.3+4`).
  Future<String> getAppVersion();
}
