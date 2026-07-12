import 'package:flutter/material.dart';

class _FruitModel {
  const _FruitModel({
    required this.name,
    required this.icon,
  });

  final String name;
  final IconData icon;
}

const _fruits = <_FruitModel>[
  _FruitModel(name: 'Apple', icon: Icons.apple),
  _FruitModel(name: 'Banana', icon: Icons.set_meal),
  _FruitModel(name: 'Cherry', icon: Icons.circle),
  _FruitModel(name: 'Grape', icon: Icons.grain),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DropdownMenuSample(),
    ),
  );
}

/// Sample demonstrating `DropdownMenuSample`.
class DropdownMenuSample extends StatefulWidget {
  /// Creates a [DropdownMenuSample].
  const DropdownMenuSample({super.key});

  @override
  State<DropdownMenuSample> createState() => _DropdownMenuSampleState();
}

class _DropdownMenuSampleState extends State<DropdownMenuSample> {
  String? _selectedFruit = _fruits.first.name;
  String? _validatedFruit;

  List<DropdownMenuEntry<String>> _getEntries({bool withTrailing = false}) {
    return _fruits
        .map(
          (fruit) => DropdownMenuEntry(
            value: fruit.name,
            label: fruit.name,
            leadingIcon: Icon(fruit.icon),
            trailingIcon: withTrailing && fruit.name == _selectedFruit
                ? const Icon(Icons.check)
                : null,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Standard DropdownMenu'),
              const SizedBox(height: 8),
              DropdownMenu<String>(
                initialSelection: _selectedFruit,
                dropdownMenuEntries: _getEntries(),
                onSelected: (value) {
                  setState(() {
                    _selectedFruit = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text('With label and helper text'),
              const SizedBox(height: 8),
              DropdownMenu<String>(
                initialSelection: _selectedFruit,
                label: const Text('Fruit'),
                helperText: 'Choose your favorite',
                dropdownMenuEntries: _getEntries(),
                onSelected: (value) {
                  setState(() {
                    _selectedFruit = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text('Trailing icon on selected entry'),
              const SizedBox(height: 8),
              DropdownMenu<String>(
                initialSelection: _selectedFruit,
                dropdownMenuEntries: _getEntries(withTrailing: true),
                onSelected: (value) {
                  setState(() {
                    _selectedFruit = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text('Searchable & disabled entry'),
              const SizedBox(height: 8),
              DropdownMenu<String>(
                initialSelection: _selectedFruit,
                dropdownMenuEntries: <DropdownMenuEntry<String>>[
                  for (final fruit in _fruits)
                    DropdownMenuEntry(
                      value: fruit.name,
                      label: fruit.name,
                      leadingIcon: Icon(fruit.icon),
                      enabled: fruit.name != 'Grape',
                    ),
                ],
                onSelected: (value) {
                  setState(() {
                    _selectedFruit = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text('Fixed width & custom menu height'),
              const SizedBox(height: 8),
              DropdownMenu<String>(
                initialSelection: _selectedFruit,
                width: 180,
                menuHeight: 150,
                dropdownMenuEntries: _getEntries(),
                onSelected: (value) {
                  setState(() {
                    _selectedFruit = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text('With validation (errorText)'),
              const SizedBox(height: 8),
              DropdownMenu<String>(
                label: const Text('Fruit'),
                errorText:
                    _validatedFruit == null ? 'This field is required' : null,
                dropdownMenuEntries: _getEntries(),
                onSelected: (value) {
                  setState(() {
                    _validatedFruit = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text('Disabled DropdownMenu'),
              const SizedBox(height: 8),
              DropdownMenu<String>(
                enabled: false,
                initialSelection: _selectedFruit,
                dropdownMenuEntries: _getEntries(),
                onSelected: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
