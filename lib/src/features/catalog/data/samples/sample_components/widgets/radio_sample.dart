import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RadioSample(),
    ),
  );
}

/// Sample demonstrating `RadioSample`.
class RadioSample extends StatefulWidget {
  /// Creates a [RadioSample].
  const RadioSample({super.key});

  @override
  State<RadioSample> createState() => _RadioSampleState();
}

class _RadioSampleState extends State<RadioSample> {
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RadioGroup<int>(
                  groupValue: _radioIndex,
                  onChanged: _updateRadioIndex,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      return Radio<int>(value: index);
                    }),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return Radio<int>(
                      value: index,
                      enabled: false,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
