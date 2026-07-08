import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DividerSample(),
    ),
  );
}

/// Sample demonstrating `DividerSample`.
class DividerSample extends StatelessWidget {
  /// Creates a [DividerSample].
  const DividerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Divider(),
      ),
    );
  }
}
