import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageSample(),
    ),
  );
}

/// Sample demonstrating `ImageSample`.
class ImageSample extends StatelessWidget {
  /// Creates a [ImageSample].
  const ImageSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/flutter_logo.png',
        ),
      ),
    );
  }
}
