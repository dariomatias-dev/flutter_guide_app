import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReorderableListViewSample(),
    ),
  );
}

class ReorderableListViewSample extends StatefulWidget {
  const ReorderableListViewSample({super.key});

  @override
  State<ReorderableListViewSample> createState() =>
      _ReorderableListViewSampleState();
}

class _ReorderableListViewSampleState extends State<ReorderableListViewSample> {
  final _items = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: ReorderableListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ListTile(
              key: Key('$index'),
              title: Text(
                'Item ${_items[index] + 1}',
              ),
              trailing: const Icon(
                Icons.drag_handle,
              ),
            );
          },
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);

            setState(() {});
          },
        ),
      ),
    );
  }
}
