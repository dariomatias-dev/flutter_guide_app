import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircularProgressIndicatorSample(),
    ),
  );
}

/// Sample demonstrating `CircularProgressIndicatorSample`.
class CircularProgressIndicatorSample extends StatelessWidget {
  /// Creates a [CircularProgressIndicatorSample].
  const CircularProgressIndicatorSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 32),
            CircularProgressSliderWidget(),
          ],
        ),
      ),
    );
  }
}

/// Sample demonstrating `CircularProgressSliderWidget`.
class CircularProgressSliderWidget extends StatefulWidget {
  /// Creates a [CircularProgressSliderWidget].
  const CircularProgressSliderWidget({super.key});

  @override
  State<CircularProgressSliderWidget> createState() =>
      _CircularProgressSliderStateWidget();
}

class _CircularProgressSliderStateWidget
    extends State<CircularProgressSliderWidget> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircularProgressIndicator(
          value: _value,
          backgroundColor: Colors.black.withAlpha(51),
        ),
        Slider(
          value: _value,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    );
  }
}
