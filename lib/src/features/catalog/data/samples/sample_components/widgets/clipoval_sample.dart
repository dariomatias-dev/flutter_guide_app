import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClipOvalSample(),
    ),
  );
}

class ClipOvalSample extends StatelessWidget {
  const ClipOvalSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipOval(
          child: Container(
            color: Colors.blue,
            width: 100.0,
            height: 100.0,
          ),
        ),
      ),
    );
  }
}
