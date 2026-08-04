import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeroSample(),
    ),
  );
}

/// Sample demonstrating `Hero`.
class HeroSample extends StatelessWidget {
  /// Creates a [HeroSample].
  const HeroSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            unawaited(
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const _HeroDetailsScreen(),
                ),
              ),
            );
          },
          child: const Hero(
            tag: 'hero-sample',
            child: FlutterLogo(size: 100),
          ),
        ),
      ),
    );
  }
}

class _HeroDetailsScreen extends StatelessWidget {
  const _HeroDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Hero(
            tag: 'hero-sample',
            child: FlutterLogo(size: 250),
          ),
        ),
      ),
    );
  }
}
