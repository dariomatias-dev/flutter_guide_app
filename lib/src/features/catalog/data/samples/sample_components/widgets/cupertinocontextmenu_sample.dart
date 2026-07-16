import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoContextMenuSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoContextMenuSample`.
class CupertinoContextMenuSample extends StatelessWidget {
  /// Creates a [CupertinoContextMenuSample].
  const CupertinoContextMenuSample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Long-press the image'),
            const SizedBox(height: 20),
            CupertinoContextMenu(
              actions: <Widget>[
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  trailingIcon: CupertinoIcons.share,
                  child: const Text('Share'),
                ),
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isDestructiveAction: true,
                  trailingIcon: CupertinoIcons.delete,
                  child: const Text('Delete'),
                ),
              ],
              child: Container(
                width: 120,
                height: 120,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
