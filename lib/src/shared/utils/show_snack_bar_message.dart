import 'package:flutter/material.dart';

void showSnackBarMessageByKey(
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  String message,
) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
        onPressed: () {},
        label: 'Ok',
      ),
    ),
  );
}
