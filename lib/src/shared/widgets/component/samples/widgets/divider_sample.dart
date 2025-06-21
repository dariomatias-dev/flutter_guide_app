import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DividerSample(),
    ),
  );
}

class DividerSample extends StatelessWidget {
  const DividerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Divider(),
      ),
    );
  }
}
