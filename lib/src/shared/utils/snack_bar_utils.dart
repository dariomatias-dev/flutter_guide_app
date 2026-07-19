import 'package:flutter/material.dart';

import 'package:flutter_guide/l10n/app_localizations.dart';

/// Helpers for showing snack bars from a context or messenger key.
abstract final class SnackBarUtils {
  static SnackBar _buildSnackBar(String text, String okLabel) {
    return SnackBar(
      content: Text(text),
      action: SnackBarAction(
        onPressed: () {},
        label: okLabel,
      ),
    );
  }

  /// Shows a snack bar using the [ScaffoldMessenger] of [context].
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      _buildSnackBar(text, AppLocalizations.of(context)!.ok),
    );
  }

  /// Shows a snack bar using a [ScaffoldMessengerState] key.
  static void showByKey(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    String text,
    String okLabel,
  ) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      _buildSnackBar(text, okLabel),
    );
  }
}
