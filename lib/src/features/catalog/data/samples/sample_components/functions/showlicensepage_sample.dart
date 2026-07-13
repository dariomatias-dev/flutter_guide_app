import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowLicensePageSample(),
    ),
  );
}

/// Sample demonstrating `ShowLicensePageSample`.
class ShowLicensePageSample extends StatelessWidget {
  /// Creates a [ShowLicensePageSample].
  const ShowLicensePageSample({super.key});

  void _showLicensePage(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: 'Flutter Guide',
      applicationVersion: '1.0.0',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showLicensePage(context),
          child: const Text('Show License Page'),
        ),
      ),
    );
  }
}
