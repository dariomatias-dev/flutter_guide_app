import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BadgeSample(),
    ),
  );
}

class BadgeSample extends StatefulWidget {
  const BadgeSample({super.key});

  @override
  State<BadgeSample> createState() => _BadgeSampleState();
}

class _BadgeSampleState extends State<BadgeSample> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Badge(
              isLabelVisible: _isVisible,
              child: const Icon(
                Icons.settings_outlined,
              ),
            ),
            const SizedBox(width: 24.0),
            Badge(
              isLabelVisible: _isVisible,
              label: const Text('99'),
              child: const Icon(
                Icons.email_outlined,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isVisible = !_isVisible;
          });
        },
        child: Icon(
          _isVisible
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
      ),
    );
  }
}
