import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckboxSample(),
    ),
  );
}

class CheckboxSample extends StatefulWidget {
  const CheckboxSample({super.key});

  @override
  State<CheckboxSample> createState() => _CheckboxSampleState();
}

class _CheckboxSampleState extends State<CheckboxSample> {
  bool _selected = false;
  bool? _selectedWithTristate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Two States',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  onChanged: (value) {
                    setState(() {
                      _selected = value!;
                    });
                  },
                  value: _selected,
                ),
                Checkbox(
                  onChanged: null,
                  value: _selected,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Three States',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  onChanged: (value) {
                    setState(() {
                      _selectedWithTristate = value;
                    });
                  },
                  tristate: true,
                  value: _selectedWithTristate,
                ),
                Checkbox(
                  onChanged: null,
                  tristate: true,
                  value: _selectedWithTristate,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
