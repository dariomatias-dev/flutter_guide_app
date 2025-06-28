import 'package:flutter/material.dart';

const _programmingLanguages = <String>[
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

final _texts = List.generate(
  _programmingLanguages.length,
  (index) {
    return Text(
      _programmingLanguages[index],
    );
  },
);

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WrapSample(),
    ),
  );
}

class WrapSample extends StatefulWidget {
  const WrapSample({super.key});

  @override
  State<WrapSample> createState() => _WrapSampleState();
}

class _WrapSampleState extends State<WrapSample> {
  double _spacing = 0.4;
  double _runSpacing = 0.1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: _spacing * 100,
          runSpacing: _runSpacing * 100,
          children: _texts,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 160.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Horizontal space of: ${(_spacing * 100).floor()}',
            ),
            Slider(
              value: _spacing,
              divisions: 10,
              onChanged: (value) {
                setState(() {
                  _spacing = value;
                });
              },
            ),
            Text(
              'Vertical space of: ${(_runSpacing * 100).floor()}',
            ),
            Slider(
              value: _runSpacing,
              divisions: 10,
              onChanged: (value) {
                setState(() {
                  _runSpacing = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
