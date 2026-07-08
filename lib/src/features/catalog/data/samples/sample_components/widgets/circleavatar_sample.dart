import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircleAvatarSample(),
    ),
  );
}

/// Sample demonstrating `CircleAvatarSample`.
class CircleAvatarSample extends StatelessWidget {
  /// Creates a [CircleAvatarSample].
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
