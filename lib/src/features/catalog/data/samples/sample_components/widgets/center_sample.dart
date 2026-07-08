import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CenterSample(),
    ),
  );
}

/// Sample demonstrating `CenterSample`.
class CenterSample extends StatelessWidget {
  /// Creates a [CenterSample].
  const CenterSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Center'),
      ),
    );
  }
}
