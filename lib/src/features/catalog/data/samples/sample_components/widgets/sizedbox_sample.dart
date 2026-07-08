import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SizedBoxSample(),
    ),
  );
}

/// Sample demonstrating `SizedBoxSample`.
class SizedBoxSample extends StatelessWidget {
  /// Creates a [SizedBoxSample].
  const SizedBoxSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/icons/flutter_icon.png',
          ),
        ),
      ),
    );
  }
}
