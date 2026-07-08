import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeAreaSample(),
    ),
  );
}

/// Sample demonstrating `SafeAreaSample`.
class SafeAreaSample extends StatefulWidget {
  /// Creates a [SafeAreaSample].
  const SafeAreaSample({super.key});

  @override
  State<SafeAreaSample> createState() => _SafeAreaSampleState();
}

class _SafeAreaSampleState extends State<SafeAreaSample> {
  void _showWithSafeArea() {
    _navigateTo(
      const WithSafeArea(),
    );
  }

  void _showWithoutSafeArea() {
    _navigateTo(
      const WithoutSafeArea(),
    );
  }

  void _navigateTo(
    Widget screen,
  ) {
    unawaited(
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (context) {
            return screen;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 12,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showWithSafeArea,
              child: const Text(
                'Screen With SafeArea',
              ),
            ),
            ElevatedButton(
              onPressed: _showWithoutSafeArea,
              child: const Text(
                'Screen Without SafeArea',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sample demonstrating `WithSafeArea`.
class WithSafeArea extends StatelessWidget {
  /// Creates a [WithSafeArea].
  const WithSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Text(
              'Screen With SafeArea',
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sample demonstrating `WithoutSafeArea`.
class WithoutSafeArea extends StatelessWidget {
  /// Creates a [WithoutSafeArea].
  const WithoutSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text(
            'Screen Without SafeArea',
          ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
