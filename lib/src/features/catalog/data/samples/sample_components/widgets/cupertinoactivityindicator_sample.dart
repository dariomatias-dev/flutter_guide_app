import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoActivityIndicatorSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoActivityIndicatorSample`.
class CupertinoActivityIndicatorSample extends StatelessWidget {
  /// Creates a [CupertinoActivityIndicatorSample].
  const CupertinoActivityIndicatorSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
