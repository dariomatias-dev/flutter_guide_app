import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/helpers/deep_link_handler.dart';
import 'package:flutter_guide/src/core/services/deep_link_source.dart';
import 'package:flutter_guide/src/shared/utils/snack_bar_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

/// Listens for incoming deep links and forwards them to a [DeepLinkHandler].
class DeepLinkService {
  /// Creates a deep link service with its collaborators.
  DeepLinkService({
    required DeepLinkHandler handler,
    required DeepLinkSource source,
    required this.logger,
    required this.router,
    required this.scaffoldMessengerKey,
  }) : _handler = handler,
       _source = source;

  final DeepLinkHandler _handler;
  final DeepLinkSource _source;

  /// Logger used to report deep link failures.
  final Logger logger;

  /// Router used by the handler to navigate.
  final GoRouter router;

  /// Key used to show messages via the root [ScaffoldMessenger].
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  StreamSubscription<Uri>? _subscription;

  /// Starts listening for the initial and subsequent deep links.
  Future<void> init() async {
    final context = router.routerDelegate.navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(context);
    final deepLinkInitFailureMessage = appLocalizations.deepLinkInitFailure;

    try {
      await _source.getInitialLink();

      _subscription = _source.uriLinkStream.listen(_handler.handle);
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

  /// Stops listening for incoming links.
  ///
  /// The stream outlives the widget that started it, and its handler holds
  /// the router and the provider container of the tree that created it, so a
  /// service left listening keeps delivering links into a tree that is gone.
  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
  }
}
