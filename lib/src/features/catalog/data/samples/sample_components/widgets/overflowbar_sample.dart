import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverflowBarSample(),
    ),
  );
}

/// Sample demonstrating `OverflowBar`.
class OverflowBarSample extends StatelessWidget {
  /// Creates a [OverflowBarSample].
  const OverflowBarSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: OverflowBar(
            spacing: 12,
            overflowSpacing: 8,
            alignment: MainAxisAlignment.end,
            overflowAlignment: OverflowBarAlignment.end,
            children: <Widget>[
              OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Save draft'),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
