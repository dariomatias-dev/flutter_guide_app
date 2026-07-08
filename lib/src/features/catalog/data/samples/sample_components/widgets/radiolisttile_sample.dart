import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RadioListTileSample(),
    ),
  );
}

/// Sample demonstrating `RadioListTileSample`.
class RadioListTileSample extends StatefulWidget {
  /// Creates a [RadioListTileSample].
  const RadioListTileSample({super.key});

  @override
  State<RadioListTileSample> createState() => RadioListTileSampleState();
}

/// Sample demonstrating `RadioListTileSampleState`.
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
        children: <Widget>[
          Text(
            'Selected radio $_radioIndex',
          ),
          const SizedBox(height: 12),
          RadioGroup<int>(
            groupValue: _radioIndex,
            onChanged: _updateRadioIndex,
            child: Column(
              children: List.generate(3, (index) {
                return RadioListTile<int>(
                  value: index,
                  title: Text(
                    'Radio $index',
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(3, (index) {
            return RadioListTile<int>(
              value: index,
              title: Text(
                'Radio $index',
              ),
              enabled: false,
            );
          }),
        ],
      ),
    );
  }
}
