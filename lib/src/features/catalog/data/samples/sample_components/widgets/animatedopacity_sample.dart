import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedOpacitySample(),
    ),
  );
}

class AnimatedOpacitySample extends StatefulWidget {
  const AnimatedOpacitySample({super.key});

  @override
  State<AnimatedOpacitySample> createState() => _AnimatedOpacitySampleState();
}

class _AnimatedOpacitySampleState extends State<AnimatedOpacitySample> {
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(
                milliseconds: 500,
              ),
              child: Image.asset(
                'assets/icons/flutter_icon.png',
                width: 200.0,
                height: 200.0,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                });
              },
              child: Text(
                _opacity == 1.0 ? 'Hide' : 'Show',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
