import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoSegmentedControlSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoSegmentedControlSample`.
class CupertinoSegmentedControlSample extends StatefulWidget {
  /// Creates a [CupertinoSegmentedControlSample].
  const CupertinoSegmentedControlSample({super.key});

  @override
  State<CupertinoSegmentedControlSample> createState() =>
      _CupertinoSegmentedControlSampleState();
}

class _CupertinoSegmentedControlSampleState
    extends State<CupertinoSegmentedControlSample> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoSegmentedControl<int>(
                groupValue: _selected,
                children: const <int, Widget>{
                  0: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Day'),
                  ),
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Week'),
                  ),
                  2: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Month'),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    _selected = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('Selected: $_selected'),
            ],
          ),
        ),
      ),
    );
  }
}
