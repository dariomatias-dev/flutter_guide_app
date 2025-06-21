import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowTimePickerSample(),
    ),
  );
}

class ShowTimePickerSample extends StatefulWidget {
  const ShowTimePickerSample({super.key});

  @override
  State<ShowTimePickerSample> createState() => _ShowTimePickerSampleState();
}

class _ShowTimePickerSampleState extends State<ShowTimePickerSample> {
  String? _time;

  Future<void> _showTimePicker() async {
    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (result != null) {
      setState(() {
        _time = result.format(context);
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
            if (_time != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Time selected: ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _time!,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ElevatedButton(
              onPressed: _showTimePicker,
              child: const Text('Select Time'),
            ),
          ],
        ),
      ),
    );
  }
}
