import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConstrainedBoxSample(),
    ),
  );
}

/// Sample demonstrating `ConstrainedBoxSample`.
class ConstrainedBoxSample extends StatelessWidget {
  /// Creates a [ConstrainedBoxSample].
  const ConstrainedBoxSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 300,
            maxHeight: 300,
          ),
          child: Image.asset(
            'assets/icons/flutter_icon.png',
          ),
        ),
      ),
    );
  }
}
