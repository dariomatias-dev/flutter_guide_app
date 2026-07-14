import 'package:flutter/material.dart';

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClipPathSample(),
    ),
  );
}

/// Sample demonstrating `ClipPathSample`.
class ClipPathSample extends StatelessWidget {
  /// Creates a [ClipPathSample].
  const ClipPathSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: _TriangleClipper(),
          child: Container(
            color: Colors.blue,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
