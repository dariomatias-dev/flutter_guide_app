import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoDialogActionSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoDialogActionSample`.
class CupertinoDialogActionSample extends StatelessWidget {
  /// Creates a [CupertinoDialogActionSample].
  const CupertinoDialogActionSample({super.key});

  void _showDialog(BuildContext context) {
    unawaited(
      showCupertinoDialog<void>(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Delete item'),
            content: const Text('This action cannot be undone.'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                isDefaultAction: true,
                child: const Text('Ok'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                isDestructiveAction: true,
                child: const Text('Delete'),
              ),
            ],
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
          onPressed: () => _showDialog(context),
          child: const Text('Show Dialog'),
        ),
      ),
    );
  }
}
