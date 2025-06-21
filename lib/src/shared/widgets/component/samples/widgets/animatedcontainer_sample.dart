import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedContainerSample(),
    ),
  );
}

class AnimatedContainerSample extends StatefulWidget {
  const AnimatedContainerSample({super.key});

  @override
  State<AnimatedContainerSample> createState() =>
      _AnimatedContainerSampleState();
}

class _AnimatedContainerSampleState extends State<AnimatedContainerSample> {
  Timer? _periodicTime;
  bool _isTimerRunning = false;
  double _size = 120;

  void _setTimer() {
    _isTimerRunning ? _stopTimer() : _startTimer();

    _isTimerRunning = !_isTimerRunning;
  }

  void _startTimer() {
    _updateSize();

    _periodicTime = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (timer) => _updateSize(),
    );
  }

  void _updateSize() {
    setState(() {
      _size = _size == 80 ? 120 : 80;
    });
  }

  void _stopTimer() {
    _periodicTime?.cancel();

    setState(() {});
  }

  @override
  void dispose() {
    _periodicTime?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 120.0,
              height: 120.0,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(
                    seconds: 1,
                  ),
                  color: Colors.blue,
                  width: _size,
                  height: _size,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: _setTimer,
              child: Text(
                _isTimerRunning ? 'Stop Timer' : 'Start Timer',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
