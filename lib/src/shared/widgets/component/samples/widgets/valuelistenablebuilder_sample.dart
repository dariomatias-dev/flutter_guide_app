import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValueListenableBuilderSample(),
    ),
  );
}

class ValueListenableBuilderSample extends StatefulWidget {
  const ValueListenableBuilderSample({super.key});

  @override
  State<ValueListenableBuilderSample> createState() =>
      _ValueListenableBuilderSampleState();
}

class _ValueListenableBuilderSampleState
    extends State<ValueListenableBuilderSample> {
  final _countNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: _countNotifier,
          builder: (context, value, child) {
            return Text(
              value.toString(),
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
