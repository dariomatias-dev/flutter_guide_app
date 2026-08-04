import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScrollbarSample(),
    ),
  );
}

/// Sample demonstrating `Scrollbar`.
class ScrollbarSample extends StatefulWidget {
  /// Creates a [ScrollbarSample].
  const ScrollbarSample({super.key});

  @override
  State<ScrollbarSample> createState() => _ScrollbarSampleState();
}

class _ScrollbarSampleState extends State<ScrollbarSample> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: _controller,
        thumbVisibility: true,
        child: ListView.builder(
          controller: _controller,
          itemCount: 40,
          itemBuilder: (context, index) {
            return ListTile(title: Text('Item $index'));
          },
        ),
      ),
    );
  }
}
