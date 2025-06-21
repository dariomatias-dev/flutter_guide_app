import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OutlinedButtonSample(),
    ),
  );
}

class OutlinedButtonSample extends StatelessWidget {
  const OutlinedButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {},
              child: const Text('Enabled'),
            ),
            const SizedBox(width: 12.0),
            const OutlinedButton(
              onPressed: null,
              child: Text('Disabled'),
            ),
          ],
        ),
      ),
    );
  }
}
