import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppBarSample(),
    ),
  );
}

class AppBarSample extends StatelessWidget {
  const AppBarSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
        title: const Text('Title'),
        centerTitle: true,
        actions: const <Widget>[
          Icon(
            Icons.notifications_none,
          ),
          SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
