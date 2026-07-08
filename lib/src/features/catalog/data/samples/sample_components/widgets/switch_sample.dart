import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SwitchSample(),
    ),
  );
}

/// Sample demonstrating `SwitchSample`.
class SwitchSample extends StatefulWidget {
  /// Creates a [SwitchSample].
  const SwitchSample({super.key});

  @override
  State<SwitchSample> createState() => _SwitchSampleState();
}

class _SwitchSampleState extends State<SwitchSample> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch(
                  value: _isEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isEnabled = !_isEnabled;
                    });
                  },
                ),
                const SizedBox(width: 8),
                Switch(
                  value: _isEnabled,
                  thumbIcon: WidgetStatePropertyAll(
                    Icon(
                      _isEnabled ? Icons.check : Icons.close,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isEnabled = !_isEnabled;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch(
                  value: _isEnabled,
                  onChanged: null,
                ),
                const SizedBox(width: 8),
                Switch(
                  value: _isEnabled,
                  thumbIcon: WidgetStatePropertyAll(
                    Icon(
                      _isEnabled ? Icons.check : Icons.close,
                    ),
                  ),
                  onChanged: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
