import 'package:flutter/material.dart';

const _programmingLanguages = <String>[
  'Dart',
  'Python',
  'JavaScript',
  'Java',
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FilterChipSample(),
    ),
  );
}

class FilterChipSample extends StatefulWidget {
  const FilterChipSample({super.key});

  @override
  State<FilterChipSample> createState() => _FilterChipSampleState();
}

class _FilterChipSampleState extends State<FilterChipSample> {
  final _selectedProgrammingLanguages = <String>[];

  void _update(
    String programmingLanguage,
  ) {
    if (_selectedProgrammingLanguages.contains(
      programmingLanguage,
    )) {
      _selectedProgrammingLanguages.remove(
        programmingLanguage,
      );
    } else {
      _selectedProgrammingLanguages.add(
        programmingLanguage,
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                alignment: WrapAlignment.center,
                children: List.generate(_programmingLanguages.length, (index) {
                  final programmingLanguage = _programmingLanguages[index];

                  return FilterChip(
                    label: Text(programmingLanguage),
                    selected: _selectedProgrammingLanguages.contains(
                      programmingLanguage,
                    ),
                    onSelected: (value) => _update(
                      programmingLanguage,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                alignment: WrapAlignment.center,
                children: List.generate(_programmingLanguages.length, (index) {
                  final programmingLanguage = _programmingLanguages[index];

                  return FilterChip(
                    label: Text(programmingLanguage),
                    selected: _selectedProgrammingLanguages.contains(
                      programmingLanguage,
                    ),
                    onSelected: null,
                  );
                }),
              ),
              const SizedBox(height: 20.0),
              if (_selectedProgrammingLanguages.isNotEmpty)
                RichText(
                  text: TextSpan(
                    text: '',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Search for: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: _selectedProgrammingLanguages.reduce(
                          (value, element) {
                            return '$element, $value';
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
