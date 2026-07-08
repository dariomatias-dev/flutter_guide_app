import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InteractiveViewerSample(),
    ),
  );
}

/// Sample demonstrating `InteractiveViewerSample`.
class InteractiveViewerSample extends StatelessWidget {
  /// Creates a [InteractiveViewerSample].
  const InteractiveViewerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        child: Center(
          child: Image.asset(
            'assets/icons/flutter_icon.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
