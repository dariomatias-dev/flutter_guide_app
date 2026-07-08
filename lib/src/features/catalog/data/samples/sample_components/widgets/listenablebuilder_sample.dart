import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListenableBuilderSample(),
    ),
  );
}

/// Sample demonstrating `ListenableBuilderSample`.
class ListenableBuilderSample extends StatefulWidget {
  /// Creates a [ListenableBuilderSample].
  const ListenableBuilderSample({super.key});

  @override
  State<ListenableBuilderSample> createState() =>
      _ListenableBuilderSampleState();
}

class _ListenableBuilderSampleState extends State<ListenableBuilderSample> {
  final ValueNotifier<int> _countNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListenableBuilder(
          listenable: _countNotifier,
          builder: (context, child) {
            return Text(
              _countNotifier.value.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _countNotifier.value = _countNotifier.value + 1;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
