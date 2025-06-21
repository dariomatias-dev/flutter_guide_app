import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopupMenuButtonSample(),
    ),
  );
}

class PopupMenuButtonSample extends StatelessWidget {
  const PopupMenuButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PopupMenuButton(
          itemBuilder: (context) {
            return List.generate(5, (index) {
              return PopupMenuItem(
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
