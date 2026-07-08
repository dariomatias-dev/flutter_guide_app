import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListViewSample(),
    ),
  );
}

/// Sample demonstrating `ListViewSample`.
class ListViewSample extends StatelessWidget {
  /// Creates a [ListViewSample].
  const ListViewSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Item $index',
            ),
          );
        },
      ),
    );
  }
}
