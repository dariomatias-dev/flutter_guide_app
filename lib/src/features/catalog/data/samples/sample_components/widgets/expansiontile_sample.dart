import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpansionTileSample(),
    ),
  );
}

/// Sample demonstrating `ExpansionTileSample`.
class ExpansionTileSample extends StatelessWidget {
  /// Creates a [ExpansionTileSample].
  const ExpansionTileSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ExpansionTile(
          title: const Text('Title'),
          children: List.generate(3, (index) {
            return ListTile(
              title: Text(
                'Content ${index + 1}',
              ),
            );
          }),
        ),
      ),
    );
  }
}
