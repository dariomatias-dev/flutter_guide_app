import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoActionSheetSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoActionSheetSample`.
class CupertinoActionSheetSample extends StatelessWidget {
  /// Creates a [CupertinoActionSheetSample].
  const CupertinoActionSheetSample({super.key});

  void _showActionSheet(BuildContext context) {
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
          onPressed: () => _showActionSheet(context),
          child: const Text('Show Action Sheet'),
        ),
      ),
    );
  }
}
