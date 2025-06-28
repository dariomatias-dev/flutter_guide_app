import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BackButtonSample(),
    ),
  );
}

class BackButtonSample extends StatelessWidget {
  const BackButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackButton(),
    );
  }
}
