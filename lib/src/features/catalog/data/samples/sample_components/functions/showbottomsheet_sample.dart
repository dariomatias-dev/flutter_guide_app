import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowBottomSheetSample(),
    ),
  );
}

/// Sample demonstrating `ShowBottomSheetSample`.
class ShowBottomSheetSample extends StatefulWidget {
  /// Creates a [ShowBottomSheetSample].
  const ShowBottomSheetSample({super.key});

  @override
  State<ShowBottomSheetSample> createState() => _ShowBottomSheetSampleState();
}

class _ShowBottomSheetSampleState extends State<ShowBottomSheetSample> {
  final ValueNotifier<bool> _isOpen = ValueNotifier(false);

  PersistentBottomSheetController? _persistentBottomSheetController;

  void _bottomSheetHandle() {
    _isOpen.value ? _closeBottomSheet() : _showBottomSheet();
  }

  void _showBottomSheet() {
    _isOpen.value = !_isOpen.value;

    _persistentBottomSheetController = showBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 16),
            const Text(
              'Actions:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            ListTile(
              onTap: _closeBottomSheet,
              leading: const Icon(Icons.share),
              title: const Text('Share'),
            ),
            ListTile(
              onTap: _closeBottomSheet,
              leading: const Icon(Icons.link),
              title: const Text('Copy Link'),
            ),
            ListTile(
              onTap: _closeBottomSheet,
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit'),
            ),
            ListTile(
              onTap: _closeBottomSheet,
              leading: const Icon(Icons.delete_outline),
              title: const Text('Delete'),
            ),
          ],
        );
      },
    );

    unawaited(
      _persistentBottomSheetController?.closed.then((value) {
        _isOpen.value = !_isOpen.value;
      }),
    );
  }

  void _closeBottomSheet() {
    _persistentBottomSheetController?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _bottomSheetHandle,
          child: ValueListenableBuilder(
            valueListenable: _isOpen,
            builder: (context, value, child) {
              return Text(
                value ? 'Close Modal' : 'Show Modal',
              );
            },
          ),
        ),
      ),
    );
  }
}
