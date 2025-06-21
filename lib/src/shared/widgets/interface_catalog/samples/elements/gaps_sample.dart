import 'package:flutter/material.dart';

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

class GapsSample extends StatefulWidget {
  const GapsSample({super.key});

  @override
  State<GapsSample> createState() => _GapsSampleState();
}

class _GapsSampleState extends State<GapsSample> {
  double _gap = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: List.generate(
              programmingLanguages.length * 2 - 1,
              (index) {
                if (index % 2 == 1) {
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 6.0),
          Text(
            'Gap: $_gap',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Slider(
            value: _gap,
            min: 0.0,
            max: 40.0,
            divisions: 20,
            onChanged: (value) {
              setState(() {
                _gap = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
