import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/helpers/deep_link_handler.dart';
import 'package:flutter_guide/src/shared/utils/snack_bar_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

/// Listens for incoming deep links and forwards them to a [DeepLinkHandler].
class DeepLinkService {
  /// Creates a deep link service with its collaborators.
  DeepLinkService({
    required DeepLinkHandler handler,
    required this.logger,
    required this.router,
    required this.scaffoldMessengerKey,
  }) : _handler = handler;

  final DeepLinkHandler _handler;

  /// Logger used to report deep link failures.
  final Logger logger;

  /// Router used by the handler to navigate.
  final GoRouter router;

  /// Key used to show messages via the root [ScaffoldMessenger].
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  final _appLinks = AppLinks();

  /// Starts listening for the initial and subsequent deep links.
  Future<void> init() async {
    final context = router.routerDelegate.navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(context)!;
    final deepLinkInitFailureMessage = appLocalizations.deepLinkInitFailure;

    try {
      await _appLinks.getInitialLink();

      _appLinks.uriLinkStream.listen(_handler.handle);
    } on Object catch (err, stackTrace) {
      logger.e(
        'Deep Link',
        error: err,
        stackTrace: stackTrace,
      );

      SnackBarUtils.showByKey(
        scaffoldMessengerKey,
        deepLinkInitFailureMessage,
        appLocalizations.ok,
      );
    }
  }
}
