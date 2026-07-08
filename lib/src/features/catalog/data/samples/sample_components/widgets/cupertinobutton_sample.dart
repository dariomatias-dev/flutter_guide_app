import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoButtonSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoButtonSample`.
class CupertinoButtonSample extends StatelessWidget {
  /// Creates a [CupertinoButtonSample].
  const CupertinoButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              onPressed: () {},
              child: const Text('Enabled'),
            ),
            const SizedBox(width: 12),
            const CupertinoButton(
              onPressed: null,
              child: Text('Disabled'),
            ),
          ],
        ),
      ),
    );
  }
}
