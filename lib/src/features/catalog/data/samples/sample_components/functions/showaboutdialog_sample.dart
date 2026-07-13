import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowAboutDialogSample(),
    ),
  );
}

/// Sample demonstrating `ShowAboutDialogSample`.
class ShowAboutDialogSample extends StatelessWidget {
  /// Creates a [ShowAboutDialogSample].
  const ShowAboutDialogSample({super.key});

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Flutter Guide',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.flutter_dash),
      children: const <Widget>[
        Text('A catalog of Flutter widgets and functions.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showAboutDialog(context),
          child: const Text('Show About Dialog'),
        ),
      ),
    );
  }
}
