import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffoldSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoPageScaffoldSample`.
class CupertinoPageScaffoldSample extends StatelessWidget {
  /// Creates a [CupertinoPageScaffoldSample].
  const CupertinoPageScaffoldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Title'),
      ),
      child: Center(
        child: Text('Body'),
      ),
    );
  }
}
