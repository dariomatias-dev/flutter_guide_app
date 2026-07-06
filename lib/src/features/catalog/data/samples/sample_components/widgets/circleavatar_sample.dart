import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircleAvatarSample(),
    ),
  );
}

class CircleAvatarSample extends StatelessWidget {
  const CircleAvatarSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircleAvatar(
          child: Icon(
            Icons.person,
          ),
        ),
      ),
    );
  }
}
