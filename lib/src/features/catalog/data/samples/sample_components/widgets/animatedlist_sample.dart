import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedListSample(),
    ),
  );
}

/// Sample demonstrating `AnimatedList`.
class AnimatedListSample extends StatefulWidget {
  /// Creates a [AnimatedListSample].
  const AnimatedListSample({super.key});

  @override
  State<AnimatedListSample> createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _items = <int>[1, 2, 3];
  var _nextValue = 4;

  void _insert() {
    final index = _items.length;

    _items.add(_nextValue++);

    _listKey.currentState?.insertItem(index);
  }

  void _removeAt(int index) {
    final removedValue = _items.removeAt(index);

    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _ListTile(value: removedValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _insert,
        child: const Icon(Icons.add),
      ),
      body: AnimatedList(
        key: _listKey,
        padding: const EdgeInsets.all(16),
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: _ListTile(
              value: _items[index],
              onRemove: () => _removeAt(index),
            ),
          );
        },
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({required this.value, this.onRemove});

  final int value;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Item $value'),
        trailing: onRemove == null
            ? null
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onRemove,
              ),
      ),
    );
  }
}
