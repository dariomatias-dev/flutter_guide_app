import 'dart:math';

import 'package:flutter/material.dart';

final _elements = List.generate(100, (index) {
  return Container(
    color: Color.fromARGB(
      255,
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextInt(255),
    ),
  );
});

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GridViewSample(),
    ),
  );
}

class GridViewSample extends StatefulWidget {
  const GridViewSample({super.key});

  @override
  State<GridViewSample> createState() => _GridViewSampleState();
}

class _GridViewSampleState extends State<GridViewSample> {
  int _crossAxisCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: GridView.builder(
          itemCount: 100,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _crossAxisCount,
          ),
          itemBuilder: (context, index) {
            return _elements[index];
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 40.0,
        child: Slider(
          value: _crossAxisCount / 10,
          min: 0.1,
          max: 0.5,
          divisions: 4,
          onChanged: (value) {
            setState(() {
              _crossAxisCount = (value * 10).floor();
            });
          },
        ),
      ),
    );
  }
}
