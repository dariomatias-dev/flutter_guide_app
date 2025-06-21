import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChipSample(),
    ),
  );
}

class ChipSample extends StatelessWidget {
  const ChipSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Chip(
          label: Text('Chip'),
        ),
      ),
    );
  }
}
