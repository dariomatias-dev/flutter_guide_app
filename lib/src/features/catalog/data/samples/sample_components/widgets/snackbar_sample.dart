import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnackBarSample(),
    ),
  );
}

/// Sample demonstrating `SnackBarSample`.
class SnackBarSample extends StatefulWidget {
  /// Creates a [SnackBarSample].
  const SnackBarSample({super.key});

  @override
  State<SnackBarSample> createState() => _SnackBarSampleState();
}

class _SnackBarSampleState extends State<SnackBarSample> {
  void _showBasicSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Product saved to favorites list.',
        ),
      ),
    );
  }

  void _showInteractiveSnackBar() {
    final snackBar = SnackBar(
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
      content: const Text(
        'Email successfully archived.',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }

  void _showFloatingSnackBar() {
    final snackBar = SnackBar(
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
      content: const Text(
        'No internet connection.',
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 16,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showBasicSnackBar,
              child: const Text(
                'Show Basic SnackBar',
              ),
            ),
            ElevatedButton(
              onPressed: _showInteractiveSnackBar,
              child: const Text(
                'Show Interactive SnackBar',
              ),
            ),
            ElevatedButton(
              onPressed: _showFloatingSnackBar,
              child: const Text(
                'Show Floating SnackBar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
