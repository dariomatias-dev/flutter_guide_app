import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomScrollViewSample(),
    ),
  );
}

/// Sample demonstrating `CustomScrollView`.
class CustomScrollViewSample extends StatelessWidget {
  /// Creates a [CustomScrollViewSample].
  const CustomScrollViewSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('CustomScrollView'),
              background: Container(color: Colors.deepPurple),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.deepPurple.shade100,
                    child: Text('${index + 1}'),
                  );
                },
                childCount: 9,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(title: Text('Row $index'));
              },
              childCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}
