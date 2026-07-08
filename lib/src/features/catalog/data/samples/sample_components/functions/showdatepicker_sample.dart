import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowDatePickerSample(),
    ),
  );
}

/// Sample demonstrating `ShowDatePickerSample`.
class ShowDatePickerSample extends StatefulWidget {
  /// Creates a [ShowDatePickerSample].
  const ShowDatePickerSample({super.key});

  @override
  State<ShowDatePickerSample> createState() => _ShowDatePickerSampleState();
}

class _ShowDatePickerSampleState extends State<ShowDatePickerSample> {
  String? _date;

  Future<void> _showDatePicker() async {
    if (_date != null) {
      setState(() {
        _date = null;
      });
    }

    final result = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (result != null) {
      setState(() {
        _date = DateFormat('MM/dd/yyyy').format(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_date != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Date selected: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _date!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ElevatedButton(
              onPressed: _showDatePicker,
              child: const Text('Select Date'),
            ),
          ],
        ),
      ),
    );
  }
}
