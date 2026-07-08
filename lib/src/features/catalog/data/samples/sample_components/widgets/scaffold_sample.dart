import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldSample(),
    ),
  );
}

/// Sample demonstrating `ScaffoldSample`.
class ScaffoldSample extends StatelessWidget {
  /// Creates a [ScaffoldSample].
  const ScaffoldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: const Center(
        child: Text('Body'),
      ),
    );
  }
}
