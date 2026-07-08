import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BackButtonSample(),
    ),
  );
}

/// Sample demonstrating `BackButtonSample`.
class BackButtonSample extends StatelessWidget {
  /// Creates a [BackButtonSample].
  const BackButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackButton(),
    );
  }
}
