import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSvgSample(),
    ),
  );
}

/// Sample demonstrating `FlutterSvgSample`.
class FlutterSvgSample extends StatelessWidget {
  /// Creates a [FlutterSvgSample].
  const FlutterSvgSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 200,
          ),
          child: SvgPicture.asset(
            'assets/icons/flutter_icon.svg',
          ),
        ),
      ),
    );
  }
}
