import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoRadioSample(),
    ),
  );
}

class CupertinoRadioSample extends StatefulWidget {
  const CupertinoRadioSample({super.key});

  @override
  State<CupertinoRadioSample> createState() => _CupertinoRadioSampleState();
}

class _CupertinoRadioSampleState extends State<CupertinoRadioSample> {
  int _radioIndex = 0;

  void _updateRadioIndex(int? value) {
    setState(() {
      _radioIndex = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
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
                    return CupertinoRadio(
                      value: index,
                      inactiveColor: Colors.grey.shade400.withOpacity(0.6),
                      groupValue: _radioIndex,
                      onChanged: _updateRadioIndex,
                    );
                  }),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return CupertinoRadio(
                      value: index,
                      inactiveColor: Colors.grey.shade300,
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
