import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClipRRectSample(),
    ),
  );
}

/// Sample demonstrating `ClipRRectSample`.
class ClipRRectSample extends StatelessWidget {
  /// Creates a [ClipRRectSample].
  const ClipRRectSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
