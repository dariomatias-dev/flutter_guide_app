import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DropdownButtonSample(),
    ),
  );
}

class DropdownButtonSample extends StatefulWidget {
  const DropdownButtonSample({super.key});

  @override
  State<DropdownButtonSample> createState() => _DropdownButtonSampleState();
}

class _DropdownButtonSampleState extends State<DropdownButtonSample> {
  int _value = 1;

  void _updateValue(int? value) {
    setState(() {
      _value = value!;
    });
  }

  List<DropdownMenuItem<int>> _getDropdownMenuItems() {
    return List.generate(5, (index) {
      return DropdownMenuItem(
        value: index + 1,
        child: Text(
          'Item ${index + 1}',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Standard DropdownButton',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<int>(
                  value: _value,
                  items: _getDropdownMenuItems(),
                  onChanged: _updateValue,
                ),
                const SizedBox(width: 12.0),
                DropdownButton<int>(
                  value: _value,
                  items: _getDropdownMenuItems(),
                  onChanged: null,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              'DropdownButton without underline',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _value,
                    items: _getDropdownMenuItems(),
                    onChanged: _updateValue,
                  ),
                ),
                const SizedBox(width: 12.0),
                DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _value,
                    items: _getDropdownMenuItems(),
                    onChanged: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
