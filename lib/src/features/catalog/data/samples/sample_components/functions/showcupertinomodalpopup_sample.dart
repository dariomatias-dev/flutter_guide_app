import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowCupertinoModalPopupSample(),
    ),
  );
}

/// Sample demonstrating `ShowCupertinoModalPopupSample`.
class ShowCupertinoModalPopupSample extends StatelessWidget {
  /// Creates a [ShowCupertinoModalPopupSample].
  const ShowCupertinoModalPopupSample({super.key});

  void _showCupertinoModalPopup(BuildContext context) {
    unawaited(
      showCupertinoModalPopup<void>(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: const Text('Options'),
            message: const Text('Choose an action'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Share'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                isDestructiveAction: true,
                child: const Text('Delete'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          onPressed: () => _showCupertinoModalPopup(context),
          child: const Text('Show Modal Popup'),
        ),
      ),
    );
  }
}
