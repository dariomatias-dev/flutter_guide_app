import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:logger/logger.dart';

import 'package:flutter_guide/src/core/helpers/deep_link_handler.dart';

import 'package:flutter_guide/src/shared/utils/show_snack_bar_message.dart';

class DeepLinkService {
  final DeepLinkHandler _handler;
  final Logger logger;
  final GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  DeepLinkService({
    required DeepLinkHandler handler,
    required this.logger,
    required this.navigatorKey,
    required this.scaffoldMessengerKey,
  }) : _handler = handler;

  final _appLinks = AppLinks();

  void init() async {
    final deepLinkInitFailureMessage = AppLocalizations.of(
      navigatorKey.currentState!.context,
    )!
        .deepLinkInitFailure;

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

      showSnackBarMessageByKey(
        scaffoldMessengerKey,
        deepLinkInitFailureMessage,
      );
    }
  }
}
