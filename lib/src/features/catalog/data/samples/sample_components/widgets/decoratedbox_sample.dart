import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DecoratedBoxSample(),
    ),
  );
}

/// Sample demonstrating `DecoratedBoxSample`.
class DecoratedBoxSample extends StatelessWidget {
  /// Creates a [DecoratedBoxSample].
  const DecoratedBoxSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/nature/image_5.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
