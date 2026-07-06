import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IgnorePointerSample(),
    ),
  );
}

class IgnorePointerSample extends StatefulWidget {
  const IgnorePointerSample({super.key});

  @override
  State<IgnorePointerSample> createState() => _IgnorePointerSampleState();
}

class _IgnorePointerSampleState extends State<IgnorePointerSample> {
  bool _isIgnoring = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IgnorePointer(
              ignoring: _isIgnoring,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Press Me'),
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                setState(() {
                  _isIgnoring = !_isIgnoring;
                });
              },
              child: Text(
                _isIgnoring ? 'Enable Button' : 'Disable Button',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
