import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PositionedSample(),
    ),
  );
}

/// Sample demonstrating `PositionedSample`.
class PositionedSample extends StatelessWidget {
  /// Creates a [PositionedSample].
  const PositionedSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(width: 60, height: 60, color: Colors.blue),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(width: 60, height: 60, color: Colors.red),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child:
                      Container(width: 60, height: 60, color: Colors.green),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child:
                      Container(width: 60, height: 60, color: Colors.orange),
                ),
                const Positioned.fill(
                  child: Center(
                    child: Text('Stack'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
