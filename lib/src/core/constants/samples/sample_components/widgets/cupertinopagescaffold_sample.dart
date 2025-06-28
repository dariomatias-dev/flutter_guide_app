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

class CupertinoPageScaffoldSample extends StatelessWidget {
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
