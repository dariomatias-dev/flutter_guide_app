import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedCrossFadeSample(),
    ),
  );
}

/// Sample demonstrating `AnimatedCrossFade`.
class AnimatedCrossFadeSample extends StatefulWidget {
  /// Creates a [AnimatedCrossFadeSample].
  const AnimatedCrossFadeSample({super.key});

  @override
  State<AnimatedCrossFadeSample> createState() =>
      _AnimatedCrossFadeSampleState();
}

class _AnimatedCrossFadeSampleState extends State<AnimatedCrossFadeSample> {
  var _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 400),
              crossFadeState: _showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: const FlutterLogo(size: 150),
              secondChild: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 150,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showFirst = !_showFirst;
                });
              },
              child: const Text('Toggle'),
            ),
          ],
        ),
      ),
    );
  }
}
