import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListenableBuilderSample(),
    ),
  );
}

class ListenableBuilderSample extends StatefulWidget {
  const ListenableBuilderSample({super.key});

  @override
  State<ListenableBuilderSample> createState() =>
      _ListenableBuilderSampleState();
}

class _ListenableBuilderSampleState extends State<ListenableBuilderSample> {
  final _countNotifier = ValueNotifier(0);

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
                fontSize: 20.0,
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
