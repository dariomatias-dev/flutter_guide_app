import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

final _effects = <Animate Function({
  Duration? duration,
})>[
  const Text(
    'Hello World!',
  ).animate().blur,
  const Text(
    'Hello World!',
  ).animate().flip,
  const Text(
    'Hello World!',
  ).animate().fade,
  const Text(
    'Hello World!',
  ).animate().fadeOut,
  const Text(
    'Hello World!',
  ).animate().scale,
  const Text(
    'Hello World!',
  ).animate().show,
  const Text(
    'Hello World!',
  ).animate().slide,
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterAnimateSample(),
    ),
  );
}

class FlutterAnimateSample extends StatefulWidget {
  const FlutterAnimateSample({super.key});

  @override
  State<FlutterAnimateSample> createState() => _FlutterAnimateSampleState();
}

class _FlutterAnimateSampleState extends State<FlutterAnimateSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                key: GlobalKey(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _effects.length,
                    (index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                        child: _effects[index](
                          duration: const Duration(
                            seconds: 1,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Restart'),
            ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
