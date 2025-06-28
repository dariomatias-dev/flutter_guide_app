import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RadioListTileSample(),
    ),
  );
}

class RadioListTileSample extends StatefulWidget {
  const RadioListTileSample({super.key});

  @override
  State<RadioListTileSample> createState() => RadioListTileSampleState();
}

class RadioListTileSampleState extends State<RadioListTileSample> {
  int _radioIndex = 0;

  void _updateRadioIndex(int? value) {
    setState(() {
      _radioIndex = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Selected radio $_radioIndex',
          ),
          const SizedBox(height: 12.0),
          ...List.generate(3, (index) {
            return RadioListTile(
              value: index,
              groupValue: _radioIndex,
              title: Text(
                'Radio $index',
              ),
              onChanged: _updateRadioIndex,
            );
          }),
          const SizedBox(height: 12.0),
          ...List.generate(3, (index) {
            return RadioListTile(
              value: index,
              groupValue: _radioIndex,
              title: Text(
                'Radio $index',
              ),
              onChanged: null,
            );
          }),
        ],
      ),
    );
  }
}
