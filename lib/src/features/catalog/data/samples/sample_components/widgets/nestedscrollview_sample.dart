import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NestedScrollViewSample(),
    ),
  );
}

/// Sample demonstrating `NestedScrollView`.
class NestedScrollViewSample extends StatelessWidget {
  /// Creates a [NestedScrollViewSample].
  const NestedScrollViewSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('NestedScrollView'),
              expandedHeight: 160,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: const FlexibleSpaceBar(
                background: ColoredBox(color: Colors.teal),
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
            return ListTile(title: Text('Item $index'));
          },
        ),
      ),
    );
  }
}
