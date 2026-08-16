import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

/// A [UrlLauncherPlatform] that records launches instead of performing them.
///
/// Call [install] in `setUp` and [restore] in `tearDown` so the swapped
/// platform instance never leaks into another test.
class FakeUrlLauncherPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {
  /// Creates a fake launcher.
  ///
  /// Set [launchResult] to `false` to simulate a url that cannot be opened.
  FakeUrlLauncherPlatform({this.launchResult = true});

  /// What [launchUrl] reports back to the caller.
  final bool launchResult;

  /// Every url passed to [launchUrl], in call order.
  final launchedUrls = <String>[];

  UrlLauncherPlatform? _previous;

  /// Makes this fake the active platform implementation.
  void install() {
    _previous = UrlLauncherPlatform.instance;
    UrlLauncherPlatform.instance = this;
  }

  /// Restores the platform instance captured at [install] time.
  void restore() {
    final previous = _previous;

    if (previous != null) {
      UrlLauncherPlatform.instance = previous;
      _previous = null;
    }
  }

  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
    launchedUrls.add(url);

    return launchResult;
  }
}
