import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowGeneralDialogSample(),
    ),
  );
}

/// Sample demonstrating `ShowGeneralDialogSample`.
class ShowGeneralDialogSample extends StatelessWidget {
  /// Creates a [ShowGeneralDialogSample].
  const ShowGeneralDialogSample({super.key});

  void _showGeneralDialog(BuildContext context) {
    unawaited(
      showGeneralDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Dismiss',
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) {
          return const Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('Custom transition dialog'),
              ),
            ),
          );
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
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
          onPressed: () => _showGeneralDialog(context),
          child: const Text('Show General Dialog'),
        ),
      ),
    );
  }
}
