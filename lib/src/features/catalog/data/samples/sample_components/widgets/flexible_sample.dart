import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlexibleSample(),
    ),
  );
}

/// Sample demonstrating `FlexibleSample`.
class FlexibleSample extends StatelessWidget {
  /// Creates a [FlexibleSample].
  const FlexibleSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('flex: 1 / 2 / 1'),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(height: 60, color: Colors.blue),
                ),
                Flexible(
                  flex: 2,
                  child: Container(height: 60, color: Colors.green),
                ),
                Flexible(
                  child: Container(height: 60, color: Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('FlexFit.loose (shrinks to child size)'),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: 40,
                    height: 60,
                    color: Colors.blue,
                  ),
                ),
                Flexible(
                  child: Container(height: 60, color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('FlexFit.tight (equivalent to Expanded)'),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    width: 40,
                    height: 60,
                    color: Colors.blue,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(height: 60, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
