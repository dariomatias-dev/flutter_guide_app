import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class CircularCountdownTimerSample extends StatelessWidget {
  const CircularCountdownTimerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularCountDownTimer(
          width: 200.0,
          height: 200.0,
          duration: 10,
          textStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          fillColor: Colors.blue,
          ringColor: Colors.blue.shade100,
          strokeCap: StrokeCap.round,
          strokeWidth: 16.0,
        ),
      ),
    );
  }
}
