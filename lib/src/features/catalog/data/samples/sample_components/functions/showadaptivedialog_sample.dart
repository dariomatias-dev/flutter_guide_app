import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowAdaptiveDialogSample(),
    ),
  );
}

/// Sample demonstrating `ShowAdaptiveDialogSample`.
class ShowAdaptiveDialogSample extends StatelessWidget {
  /// Creates a [ShowAdaptiveDialogSample].
  const ShowAdaptiveDialogSample({super.key});

  void _showAdaptiveDialog(BuildContext context) {
    unawaited(
      showAdaptiveDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text('Title'),
            content: const Text(
              'Renders as Material on Android and Cupertino on iOS.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showAdaptiveDialog(context),
          child: const Text('Show Adaptive Dialog'),
        ),
      ),
    );
  }
}
