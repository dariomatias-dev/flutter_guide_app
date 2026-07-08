import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContainerSample(),
    ),
  );
}

/// Sample demonstrating `ContainerSample`.
class ContainerSample extends StatelessWidget {
  /// Creates a [ContainerSample].
  const ContainerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 160,
          height: 160,
          color: Colors.blue,
        ),
      ),
    );
  }
}
