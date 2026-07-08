import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlaceholderSample(),
    ),
  );
}

/// Sample demonstrating `PlaceholderSample`.
class PlaceholderSample extends StatelessWidget {
  /// Creates a [PlaceholderSample].
  const PlaceholderSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Placeholder(),
    );
  }
}
