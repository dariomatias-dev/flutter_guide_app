import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SwitchListTileSample(),
    ),
  );
}

class SwitchListTileSample extends StatefulWidget {
  const SwitchListTileSample({super.key});

  @override
  State<SwitchListTileSample> createState() => _SwitchListTileSampleState();
}

class _SwitchListTileSampleState extends State<SwitchListTileSample> {
  final _selectedOptions = List.filled(2, false);

  void _updateSelectedOptions(int index, bool newValue) {
    setState(() {
      _selectedOptions[index] = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...List.generate(_selectedOptions.length, (index) {
            return SwitchListTile(
              title: Text('Switch $index'),
              value: _selectedOptions[index],
              thumbIcon: index == 1
                  ? WidgetStatePropertyAll(
                      Icon(
                        _selectedOptions[1] ? Icons.check : Icons.close,
                      ),
                    )
                  : null,
              onChanged: (value) => _updateSelectedOptions(
                index,
                value,
              ),
            );
          }),
          const SizedBox(height: 12.0),
          ...List.generate(_selectedOptions.length, (index) {
            return SwitchListTile(
              title: Text(
                'Switch $index',
              ),
              value: _selectedOptions[index],
              thumbIcon: index == 1
                  ? WidgetStatePropertyAll(
                      Icon(
                        _selectedOptions[1] ? Icons.check : Icons.close,
                      ),
                    )
                  : null,
              onChanged: null,
            );
          }),
        ],
      ),
    );
  }
}
