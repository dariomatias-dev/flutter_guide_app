import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopupMenuButtonSample(),
    ),
  );
}

/// Sample demonstrating `PopupMenuButtonSample`.
class PopupMenuButtonSample extends StatelessWidget {
  /// Creates a [PopupMenuButtonSample].
  const PopupMenuButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PopupMenuButton(
          itemBuilder: (context) {
            return List.generate(5, (index) {
              return PopupMenuItem<void>(
                child: Text(
                  'Item ${index + 1}',
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
