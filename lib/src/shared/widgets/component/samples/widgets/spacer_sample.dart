import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpacerSample(),
    ),
  );
}

class SpacerSample extends StatelessWidget {
  const SpacerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              color: Colors.blue,
            ),
            const Spacer(),
            Container(
              width: 50.0,
              height: 50.0,
              color: Colors.yellow,
            ),
            const Spacer(
              flex: 2,
            ),
            Container(
              width: 50.0,
              height: 50.0,
              color: Colors.red,
            ),
            const Spacer(
              flex: 3,
            ),
            Container(
              width: 50.0,
              height: 50.0,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
