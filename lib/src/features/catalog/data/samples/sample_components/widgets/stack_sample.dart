import 'package:flutter/material.dart';

const _colors = <Color>[
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StackSample(),
    ),
  );
}

class StackSample extends StatefulWidget {
  const StackSample({super.key});

  @override
  State<StackSample> createState() => _StackSampleState();
}

class _StackSampleState extends State<StackSample> {
  double _size = 300.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(_colors.length, (index) {
            _size -= 50.0;

            return Container(
              width: _size,
              height: _size,
              color: _colors[index],
            );
          }),
        ),
      ),
    );
  }
}
