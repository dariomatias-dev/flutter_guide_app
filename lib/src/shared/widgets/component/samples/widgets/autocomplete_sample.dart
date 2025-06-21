import 'package:flutter/material.dart';

const _programmingLanguages = <String>[
  'Dart',
  'Python',
  'JavaScript',
  'Java',
  'Ruby',
  'PHP',
  'Swift',
  'Kotlin',
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AutocompleteSample(),
    ),
  );
}

class AutocompleteSample extends StatelessWidget {
  const AutocompleteSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Autocomplete(
          optionsBuilder: (textEditingValue) {
            return _programmingLanguages.where((programmingLanguage) {
              return programmingLanguage.toLowerCase().contains(
                    textEditingValue.text.trim().toLowerCase(),
                  );
            });
          },
          onSelected: (String selection) {},
          displayStringForOption: (String option) => option,
        ),
      ),
    );
  }
}
