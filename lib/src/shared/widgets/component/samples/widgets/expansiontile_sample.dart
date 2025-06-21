import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpansionTileSample(),
    ),
  );
}

class ExpansionTileSample extends StatelessWidget {
  const ExpansionTileSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ExpansionTile(
          title: const Text('Title'),
          children: List.generate(3, (index) {
            return ListTile(
              title: Text(
                'Content ${index + 1}',
              ),
            );
          }),
        ),
      ),
    );
  }
}
