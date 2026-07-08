import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VisibilitySample(),
    ),
  );
}

/// Sample demonstrating `VisibilitySample`.
class VisibilitySample extends StatefulWidget {
  /// Creates a [VisibilitySample].
  const VisibilitySample({super.key});

  @override
  State<VisibilitySample> createState() => _VisibilitySampleState();
}

class _VisibilitySampleState extends State<VisibilitySample> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Divider(
              height: 0,
            ),
            Visibility(
              visible: isVisible,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        child: Icon(
          isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        ),
      ),
    );
  }
}
