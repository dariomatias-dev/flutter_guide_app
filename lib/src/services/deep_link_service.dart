import 'package:app_links/app_links.dart';
import 'package:logger/logger.dart';

import 'package:flutter_guide/src/core/helpers/deep_link_handler.dart';

class DeepLinkService {
  final DeepLinkHandler _handler;
  final Logger logger;

  DeepLinkService({
    required DeepLinkHandler handler,
    required this.logger,
  }) : _handler = handler;

  final _appLinks = AppLinks();

  void init() async {
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _handler.handle(initialLink);
      }

      _appLinks.uriLinkStream.listen(_handler.handle);
    } catch (err, stackTrace) {
      logger.e(
        'Deep Link',
        error: err,
        stackTrace: stackTrace,
      );
    }
  }
}
