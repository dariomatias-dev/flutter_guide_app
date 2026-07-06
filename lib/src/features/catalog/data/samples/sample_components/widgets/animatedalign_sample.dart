import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedAlignSample(),
    ),
  );
}

class AnimatedAlignSample extends StatefulWidget {
  const AnimatedAlignSample({super.key});

  @override
  State<AnimatedAlignSample> createState() => _AnimatedAlignSampleState();
}

class _AnimatedAlignSampleState extends State<AnimatedAlignSample> {
  AlignmentGeometry _alignment = Alignment.center;
  int _seconds = 2;

  void _onEnd() {
    AlignmentGeometry? alignment;

    switch (_alignment) {
      case Alignment.topCenter:
        alignment = Alignment.topRight;
        _seconds = 1;
        break;
      case Alignment.topRight:
        alignment = Alignment.bottomRight;
        _seconds = 2;
        break;
      case Alignment.bottomRight:
        alignment = Alignment.bottomLeft;
        _seconds = 1;
        break;
      case Alignment.bottomLeft:
        alignment = Alignment.topLeft;
        _seconds = 2;
        break;
      case Alignment.topLeft:
        alignment = Alignment.topRight;
        _seconds = 1;
        break;
    }

    if (alignment != null) {
      setState(() {
        _alignment = alignment!;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _alignment = Alignment.topCenter;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedAlign(
        alignment: _alignment,
        duration: Duration(
          seconds: _seconds,
        ),
        onEnd: _onEnd,
        child: Image.asset(
          'assets/icons/flutter_icon.png',
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
