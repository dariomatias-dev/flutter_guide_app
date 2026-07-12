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

/// Sample demonstrating `FilterChipSample`.
class FilterChipSample extends StatefulWidget {
  /// Creates a [FilterChipSample].
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
          horizontal: 20,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Wrap(
                spacing: 6,
                runSpacing: 6,
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
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
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
              const SizedBox(height: 20),
              if (_selectedProgrammingLanguages.isNotEmpty)
                RichText(
                  text: TextSpan(
                    text: '',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
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
