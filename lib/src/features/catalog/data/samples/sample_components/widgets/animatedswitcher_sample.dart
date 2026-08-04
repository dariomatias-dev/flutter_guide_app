import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSwitcherSample(),
    ),
  );
}

/// Sample demonstrating `AnimatedSwitcher`.
class AnimatedSwitcherSample extends StatefulWidget {
  /// Creates a [AnimatedSwitcherSample].
  const AnimatedSwitcherSample({super.key});

  @override
  State<AnimatedSwitcherSample> createState() => _AnimatedSwitcherSampleState();
}

class _AnimatedSwitcherSampleState extends State<AnimatedSwitcherSample> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                '$_count',
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _count++),
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
