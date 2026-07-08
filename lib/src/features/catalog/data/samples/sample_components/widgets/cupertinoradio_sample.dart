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

/// Sample demonstrating `CupertinoRadioSample`.
class CupertinoRadioSample extends StatefulWidget {
  /// Creates a [CupertinoRadioSample].
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
                      return CupertinoRadio<int>(
                        value: index,
                        inactiveColor: Colors.grey.shade400.withAlpha(153),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return CupertinoRadio<int>(
                      value: index,
                      inactiveColor: Colors.grey.shade300,
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
