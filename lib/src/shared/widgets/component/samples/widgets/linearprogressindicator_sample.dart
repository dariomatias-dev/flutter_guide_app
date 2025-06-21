import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LinearProgressIndicatorSample(),
    ),
  );
}

class LinearProgressIndicatorSample extends StatelessWidget {
  const LinearProgressIndicatorSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: <Widget>[
          LinearProgressIndicator(),
          Expanded(
            child: LinearProgressSliderWidget(),
          ),
        ],
      ),
    );
  }
}

class LinearProgressSliderWidget extends StatefulWidget {
  const LinearProgressSliderWidget({super.key});

  @override
  State<LinearProgressSliderWidget> createState() =>
      _CircularProgressSliderStateWidget();
}

class _CircularProgressSliderStateWidget
    extends State<LinearProgressSliderWidget> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LinearProgressIndicator(
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
