import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _fruits = <String>[
  'Apple',
  'Banana',
  'Cherry',
  'Grape',
  'Mango',
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPickerSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoPickerSample`.
class CupertinoPickerSample extends StatefulWidget {
  /// Creates a [CupertinoPickerSample].
  const CupertinoPickerSample({super.key});

  @override
  State<CupertinoPickerSample> createState() => _CupertinoPickerSampleState();
}

class _CupertinoPickerSampleState extends State<CupertinoPickerSample> {
  String? _selectedFruit;

  Future<void> _showPicker() async {
    var pickedIndex = _fruits.indexOf(_selectedFruit ?? _fruits.first);
    if (pickedIndex == -1) {
      pickedIndex = 0;
    }

    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) {
        return Container(
          height: 260,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
                child: CupertinoPicker(
                  itemExtent: 32,
                  scrollController: FixedExtentScrollController(
                    initialItem: pickedIndex,
                  ),
                  onSelectedItemChanged: (index) {
                    pickedIndex = index;
                  },
                  children: _fruits.map(Text.new).toList(),
                ),
              ),
              CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
            ],
          ),
        );
      },
    );

    setState(() {
      _selectedFruit = _fruits[pickedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedFruit != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text('Selected: $_selectedFruit'),
              ),
            CupertinoButton.filled(
              onPressed: _showPicker,
              child: const Text('Select Fruit'),
            ),
          ],
        ),
      ),
    );
  }
}
