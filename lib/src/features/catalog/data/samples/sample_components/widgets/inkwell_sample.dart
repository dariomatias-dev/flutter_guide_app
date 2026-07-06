import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InkWellSample(),
    ),
  );
}

class InkWellSample extends StatelessWidget {
  const InkWellSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20.0),
              child: Ink(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                child: const Text('Enabled'),
              ),
            ),
            const SizedBox(width: 12.0),
            InkWell(
              onTap: null,
              borderRadius: BorderRadius.circular(20.0),
              child: Ink(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                child: const Text('Disabled'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
