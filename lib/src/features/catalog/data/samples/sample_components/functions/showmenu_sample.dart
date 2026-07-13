import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowMenuSample(),
    ),
  );
}

/// Sample demonstrating `ShowMenuSample`.
class ShowMenuSample extends StatefulWidget {
  /// Creates a [ShowMenuSample].
  const ShowMenuSample({super.key});

  @override
  State<ShowMenuSample> createState() => _ShowMenuSampleState();
}

class _ShowMenuSampleState extends State<ShowMenuSample> {
  final _buttonKey = GlobalKey<State<StatefulWidget>>();
  String? _selectedFruit;

  void _showMenu() {
    final renderBox =
        _buttonKey.currentContext!.findRenderObject()! as RenderBox;
    final overlay = Navigator.of(context).overlay!.context.findRenderObject()!
        as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(Offset.zero, ancestor: overlay),
        renderBox.localToGlobal(
          renderBox.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    unawaited(
      showMenu<String>(
        context: context,
        position: position,
        items: const <PopupMenuEntry<String>>[
          PopupMenuItem(value: 'Apple', child: Text('Apple')),
          PopupMenuItem(value: 'Banana', child: Text('Banana')),
          PopupMenuItem(value: 'Cherry', child: Text('Cherry')),
        ],
      ).then((value) {
        if (value != null) {
          setState(() {
            _selectedFruit = value;
          });
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              key: _buttonKey,
              onPressed: _showMenu,
              child: const Text('Show Menu'),
            ),
            const SizedBox(height: 12),
            Text('Selected: ${_selectedFruit ?? '-'}'),
          ],
        ),
      ),
    );
  }
}
