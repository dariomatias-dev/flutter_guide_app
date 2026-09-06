/// The stream of deep links reaching the app, and the one that launched it.
///
/// Wraps the platform plugin so nothing above this contract imports it. The
/// plugin's entry point is a process-wide singleton that stops relaying once
/// its last listener cancels, which is fine for an app that subscribes once
/// and impossible to drive from more than one test.
abstract interface class DeepLinkSource {
  /// The link the app was launched with, or `null` when it was not.
  Future<Uri?> getInitialLink();

  /// Links that arrive while the app is running.
  Stream<Uri> get uriLinkStream;
}
