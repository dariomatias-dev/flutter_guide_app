import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircularProgressIndicatorSample(),
    ),
  );
}

class CircularProgressIndicatorSample extends StatelessWidget {
  const CircularProgressIndicatorSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 32.0),
            CircularProgressSliderWidget(),
          ],
        ),
      ),
    );
  }
}

class CircularProgressSliderWidget extends StatefulWidget {
  const CircularProgressSliderWidget({super.key});

  @override
  State<CircularProgressSliderWidget> createState() =>
      _CircularProgressSliderStateWidget();
}

class _CircularProgressSliderStateWidget
    extends State<CircularProgressSliderWidget> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircularProgressIndicator(
          value: _value,
          backgroundColor: Colors.black.withOpacity(0.2),
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
