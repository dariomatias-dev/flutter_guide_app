import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CardSample(),
    ),
  );
}

/// Sample demonstrating `CardSample`.
class CardSample extends StatelessWidget {
  /// Creates a [CardSample].
  const CardSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.grey.shade200,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 120,
              horizontal: 80,
            ),
            child: Text(
              'Card',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
