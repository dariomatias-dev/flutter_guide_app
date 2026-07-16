import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoSlidingSegmentedControlSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoSlidingSegmentedControlSample`.
class CupertinoSlidingSegmentedControlSample extends StatefulWidget {
  /// Creates a [CupertinoSlidingSegmentedControlSample].
  const CupertinoSlidingSegmentedControlSample({super.key});

  @override
  State<CupertinoSlidingSegmentedControlSample> createState() =>
      _CupertinoSlidingSegmentedControlSampleState();
}

class _CupertinoSlidingSegmentedControlSampleState
    extends State<CupertinoSlidingSegmentedControlSample> {
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
              CupertinoSlidingSegmentedControl<int>(
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
                    _selected = value ?? _selected;
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
