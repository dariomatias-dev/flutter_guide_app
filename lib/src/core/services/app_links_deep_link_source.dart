import 'package:app_links/app_links.dart';
import 'package:flutter_guide/src/core/services/deep_link_source.dart';

/// [DeepLinkSource] backed by the `app_links` plugin.
class AppLinksDeepLinkSource implements DeepLinkSource {
  final _appLinks = AppLinks();

  @override
  Future<Uri?> getInitialLink() => _appLinks.getInitialLink();

  @override
  Stream<Uri> get uriLinkStream => _appLinks.uriLinkStream;
}
