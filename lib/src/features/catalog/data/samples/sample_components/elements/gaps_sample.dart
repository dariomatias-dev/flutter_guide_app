import 'package:flutter/material.dart';

/// Programming languages listed in the sample.
const programmingLanguages = <String>[
  'Dart',
  'Python',
  'JavaScript',
  'Java',
  'C#',
  'C++',
  'C',
  'GoLang',
  'Kotlin',
  'Swift',
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GapsSample(),
    ),
  );
}

/// Sample demonstrating `GapsSample`.
class GapsSample extends StatefulWidget {
  /// Creates a [GapsSample].
  const GapsSample({super.key});

  @override
  State<GapsSample> createState() => _GapsSampleState();
}

class _GapsSampleState extends State<GapsSample> {
  double _gap = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: List.generate(
              programmingLanguages.length * 2 - 1,
              (index) {
                if (index.isOdd) {
                  return SizedBox(height: _gap);
                }

                return Text(
                  programmingLanguages[index ~/ 2],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 6),
            Text(
              'Gap: $_gap',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Slider(
              value: _gap,
              max: 40,
              divisions: 20,
              onChanged: (value) {
                setState(() {
                  _gap = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
