import 'dart:async';

import 'package:flutter_guide/src/core/services/deep_link_source.dart';
import 'package:flutter_test/flutter_test.dart';

/// A [DeepLinkSource] the test drives itself.
///
/// The real one answers over platform channels that stay silent outside a
/// device, and the plugin behind it keeps process-wide state that survives
/// between tests.
class FakeDeepLinkSource implements DeepLinkSource {
  /// Creates a fake that reports [initialLink] as the launching link, or
  /// throws [initialLinkError] when one is given.
  FakeDeepLinkSource({this.initialLink, this.initialLinkError});

  /// Link reported as the one that launched the app.
  final Uri? initialLink;

  /// Error thrown by [getInitialLink] instead of answering.
  final Exception? initialLinkError;

  final _controller = StreamController<Uri>.broadcast();

  /// Whether anything is currently listening for links.
  bool get isListening => _controller.hasListener;

  @override
  Future<Uri?> getInitialLink() async {
    if (initialLinkError != null) {
      throw initialLinkError!;
    }

    return initialLink;
  }

  @override
  Stream<Uri> get uriLinkStream => _controller.stream;

  /// Emits [uri] as a link that arrived while the app was running.
  void emit(Uri uri) => _controller.add(uri);

  /// Closes the link stream.
  Future<void> dispose() => _controller.close();
}

/// Creates a [FakeDeepLinkSource] closed at the end of the current test.
FakeDeepLinkSource createFakeDeepLinkSource({
  Uri? initialLink,
  Exception? initialLinkError,
}) {
  final source = FakeDeepLinkSource(
    initialLink: initialLink,
    initialLinkError: initialLinkError,
  );
  addTearDown(source.dispose);

  return source;
}
