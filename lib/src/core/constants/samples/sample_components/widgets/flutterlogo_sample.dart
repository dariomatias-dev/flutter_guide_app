import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterLogoSample(),
    ),
  );
}

class FlutterLogoSample extends StatelessWidget {
  const FlutterLogoSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 120.0,
        ),
      ),
    );
  }
}
