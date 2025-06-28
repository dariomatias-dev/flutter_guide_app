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

class FlutterSvgSample extends StatelessWidget {
  const FlutterSvgSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 200.0,
          ),
          child: SvgPicture.asset(
            'assets/icons/flutter_icon.svg',
          ),
        ),
      ),
    );
  }
}
