import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BackdropFilterSample(),
    ),
  );
}

class BackdropFilterSample extends StatefulWidget {
  const BackdropFilterSample({super.key});

  @override
  State<BackdropFilterSample> createState() => _BackdropFilterSampleState();
}

class _BackdropFilterSampleState extends State<BackdropFilterSample> {
  double _sigmaX = 0.0;
  double _sigmaY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200.0,
          height: 200.0,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/icons/flutter_icon.png',
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _sigmaX,
                    sigmaY: _sigmaY,
                  ),
                  child: Container(
                    color: Colors.black.withAlpha(0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 140.0,
        child: Column(
          children: <Widget>[
            Text(
              'SigmaX: ${_sigmaX.floor()}',
            ),
            Slider(
              value: _sigmaX / 100,
              divisions: 10,
              onChanged: (value) {
                setState(() {
                  _sigmaX = value * 100;
                });
              },
            ),
            Text(
              'SigmaY: ${_sigmaY.floor()}',
            ),
            Slider(
              value: _sigmaY / 100,
              divisions: 10,
              onChanged: (value) {
                setState(() {
                  _sigmaY = value * 100;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
