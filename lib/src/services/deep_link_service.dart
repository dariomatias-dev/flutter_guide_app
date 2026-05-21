import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/helpers/deep_link_handler.dart';

import 'package:flutter_guide/src/shared/utils/snack_bar_utils.dart';

class DeepLinkService {
  DeepLinkService({
    required DeepLinkHandler handler,
    required this.logger,
    required this.router,
    required this.scaffoldMessengerKey,
  }) : _handler = handler;

  final DeepLinkHandler _handler;
  final Logger logger;
  final GoRouter router;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  final _appLinks = AppLinks();

  void init() async {
    final context = router.routerDelegate.navigatorKey.currentContext!;
    final deepLinkInitFailureMessage =
        AppLocalizations.of(context)!.deepLinkInitFailure;

    try {
      await _appLinks.getInitialLink();

      _appLinks.uriLinkStream.listen(_handler.handle);
    } catch (err, stackTrace) {
      logger.e(
        'Deep Link',
        error: err,
        stackTrace: stackTrace,
      );

      SnackBarUtils.showByKey(
        scaffoldMessengerKey,
        deepLinkInitFailureMessage,
      );
    }
  }
}
