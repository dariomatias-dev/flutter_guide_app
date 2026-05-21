import 'package:flutter/material.dart';

class SnackBarUtils {
  static SnackBar _buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      action: SnackBarAction(
        onPressed: () {},
        label: 'Ok',
      ),
    );
  }

  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(text));
  }

  static void showByKey(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    String text,
  ) {
    scaffoldMessengerKey.currentState?.showSnackBar(_buildSnackBar(text));
  }
}
