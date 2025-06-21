import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CenterSample(),
    ),
  );
}

class CenterSample extends StatelessWidget {
  const CenterSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Center'),
      ),
    );
  }
}
