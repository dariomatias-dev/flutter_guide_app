import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoNavigationBarBackButtonSample(),
    ),
  );
}

class CupertinoNavigationBarBackButtonSample extends StatelessWidget {
  const CupertinoNavigationBarBackButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CupertinoNavigationBarBackButton(),
    );
  }
}
