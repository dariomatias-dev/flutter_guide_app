import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetectorSample(),
    ),
  );
}

class GestureDetectorSample extends StatefulWidget {
  const GestureDetectorSample({super.key});

  @override
  State<GestureDetectorSample> createState() => _GestureDetectorSampleState();
}

class _GestureDetectorSampleState extends State<GestureDetectorSample> {
  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Clicked'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _showSnackBar,
              child: const Text('Enabled'),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: null,
              child: const Text('Disabled'),
            ),
          ],
        ),
      ),
    );
  }
}
