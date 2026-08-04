import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DraggableScrollableSheetSample(),
    ),
  );
}

/// Sample demonstrating `DraggableScrollableSheet`.
class DraggableScrollableSheetSample extends StatelessWidget {
  /// Creates a [DraggableScrollableSheetSample].
  const DraggableScrollableSheetSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const Center(child: Text('Drag the sheet below')),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.15,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(blurRadius: 12, color: Colors.black26),
                  ],
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('Item $index'));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
