import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DottedBorderSample(),
    ),
  );
}

class DottedBorderSample extends StatefulWidget {
  const DottedBorderSample({super.key});

  @override
  State<DottedBorderSample> createState() => _DottedBorderSampleState();
}

class _DottedBorderSampleState extends State<DottedBorderSample> {
  double _spaceBetweenTheLines = 2.0;
  double _lineWidth = 2.0;
  double _lineSize = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DottedBorder(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          strokeWidth: _lineWidth,
          dashPattern: <double>[
            _lineSize,
            _spaceBetweenTheLines,
          ],
          child: const SizedBox(
            width: 200.0,
            height: 300.0,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Space Between the Lines: ${_spaceBetweenTheLines.floor()}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Slider(
              min: 2.0,
              max: 20.0,
              divisions: 9,
              value: _spaceBetweenTheLines,
              onChanged: (value) {
                setState(() {
                  _spaceBetweenTheLines = value;
                });
              },
            ),
            const SizedBox(height: 4.0),
            Text(
              'Line Width: ${_lineWidth.floor()}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Slider(
              min: 2.0,
              max: 20.0,
              divisions: 9,
              value: _lineWidth,
              onChanged: (value) {
                setState(() {
                  _lineWidth = value;
                });
              },
            ),
            const SizedBox(height: 4.0),
            Text(
              'Line Size: ${_lineSize.floor()}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Slider(
              min: 2.0,
              max: 20.0,
              divisions: 9,
              value: _lineSize,
              onChanged: (value) {
                setState(() {
                  _lineSize = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
