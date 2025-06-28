import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckboxListTileSample(),
    ),
  );
}

class CheckboxListTileSample extends StatefulWidget {
  const CheckboxListTileSample({super.key});

  @override
  State<CheckboxListTileSample> createState() => _CheckboxListTileSampleState();
}

class _CheckboxListTileSampleState extends State<CheckboxListTileSample> {
  bool _selected = false;
  bool? _selectedWithTristate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CheckboxListTile(
            value: _selected,
            title: const Text('Two States'),
            onChanged: (value) {
              setState(() {
                _selected = !_selected;
              });
            },
          ),
          CheckboxListTile(
            value: _selected,
            title: const Text('Two States'),
            onChanged: null,
          ),
          const SizedBox(height: 20.0),
          CheckboxListTile(
            value: _selectedWithTristate,
            title: const Text('Three States'),
            tristate: true,
            onChanged: (value) {
              setState(() {
                _selectedWithTristate = value;
              });
            },
          ),
          CheckboxListTile(
            value: _selectedWithTristate,
            title: const Text('Three States'),
            tristate: true,
            onChanged: null,
          ),
        ],
      ),
    );
  }
}
