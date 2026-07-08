import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircularCountdownTimerSample(),
    ),
  );
}

/// Sample demonstrating `CircularCountdownTimerSample`.
class CircularCountdownTimerSample extends StatelessWidget {
  /// Creates a [CircularCountdownTimerSample].
  const CircularCountdownTimerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularCountDownTimer(
          width: 200,
          height: 200,
          duration: 10,
          textStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          fillColor: Colors.blue,
          ringColor: Colors.blue.shade100,
          strokeCap: StrokeCap.round,
          strokeWidth: 16,
        ),
      ),
    );
  }
}
