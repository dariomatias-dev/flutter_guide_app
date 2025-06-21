import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RadioSample(),
    ),
  );
}

class RadioSample extends StatefulWidget {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Selected radio $_radioIndex',
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return Radio(
                      value: index,
                      groupValue: _radioIndex,
                      onChanged: _updateRadioIndex,
                    );
                  }),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return Radio(
                      value: index,
                      groupValue: _radioIndex,
                      onChanged: null,
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
