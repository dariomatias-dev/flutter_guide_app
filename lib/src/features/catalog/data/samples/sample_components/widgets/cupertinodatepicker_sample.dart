import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoDatePickerSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoDatePickerSample`.
class CupertinoDatePickerSample extends StatefulWidget {
  /// Creates a [CupertinoDatePickerSample].
  const CupertinoDatePickerSample({super.key});

  @override
  State<CupertinoDatePickerSample> createState() =>
      _CupertinoDatePickerSampleState();
}

class _CupertinoDatePickerSampleState extends State<CupertinoDatePickerSample> {
  DateTime? _selectedDate;

  Future<void> _showDatePicker() async {
    var pickedDate = _selectedDate ?? DateTime.now();

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
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: pickedDate,
                  onDateTimeChanged: (value) {
                    pickedDate = value;
                  },
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
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Date selected: ${_selectedDate!.day}/'
                  '${_selectedDate!.month}/${_selectedDate!.year}',
                ),
              ),
            CupertinoButton.filled(
              onPressed: _showDatePicker,
              child: const Text('Select Date'),
            ),
          ],
        ),
      ),
    );
  }
}
