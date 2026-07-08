import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextButtonSample(),
    ),
  );
}

/// Sample demonstrating `TextButtonSample`.
class TextButtonSample extends StatelessWidget {
  /// Creates a [TextButtonSample].
  const TextButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Text('Enabled'),
            ),
            const SizedBox(width: 12),
            const TextButton(
              onPressed: null,
              child: Text('Disabled'),
            ),
          ],
        ),
      ),
    );
  }
}
