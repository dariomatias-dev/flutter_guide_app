import 'package:flutter/material.dart';

/// Helpers for showing snack bars from a context or messenger key.
abstract final class SnackBarUtils {
  static SnackBar _buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      action: SnackBarAction(
        onPressed: () {},
        label: 'Ok',
      ),
    );
  }

  /// Shows a snack bar using the [ScaffoldMessenger] of [context].
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(text));
  }

  /// Shows a snack bar using a [ScaffoldMessengerState] key.
  static void showByKey(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    String text,
  ) {
    scaffoldMessengerKey.currentState?.showSnackBar(_buildSnackBar(text));
  }
}
