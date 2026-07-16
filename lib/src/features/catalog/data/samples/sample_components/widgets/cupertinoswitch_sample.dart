import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoSwitchSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoSwitchSample`.
class CupertinoSwitchSample extends StatefulWidget {
  /// Creates a [CupertinoSwitchSample].
  const CupertinoSwitchSample({super.key});

  @override
  State<CupertinoSwitchSample> createState() => _CupertinoSwitchSampleState();
}

class _CupertinoSwitchSampleState extends State<CupertinoSwitchSample> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoSwitch(
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                const SizedBox(width: 8),
                CupertinoSwitch(
                  value: _value,
                  activeTrackColor: CupertinoColors.systemGreen,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoSwitch(
                  value: false,
                  onChanged: null,
                ),
                SizedBox(width: 8),
                CupertinoSwitch(
                  value: true,
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
