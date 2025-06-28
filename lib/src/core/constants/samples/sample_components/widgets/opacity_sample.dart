import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OpacitySample(),
    ),
  );
}

class OpacitySample extends StatefulWidget {
  const OpacitySample({super.key});

  @override
  State<OpacitySample> createState() => _OpacitySampleState();
}

class _OpacitySampleState extends State<OpacitySample> {
  double _opacity = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 140.0,
                  ),
                  child: Opacity(
                    opacity: _opacity / 100,
                    child: Image.asset(
                      'assets/icons/flutter_icon.png',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Slider(
              label: _opacity.floor().toString(),
              value: _opacity,
              divisions: 100,
              max: 100,
              onChanged: (value) {
                setState(() {
                  _opacity = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
