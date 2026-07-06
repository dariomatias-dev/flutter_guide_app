import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChoiceChipSample(),
    ),
  );
}

class ChoiceChipSample extends StatefulWidget {
  const ChoiceChipSample({super.key});

  @override
  State<ChoiceChipSample> createState() => _ChoiceChipSampleState();
}

class _ChoiceChipSampleState extends State<ChoiceChipSample> {
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              spacing: 6.0,
              children: List.generate(3, (index) {
                return ChoiceChip(
                  label: Text('Item ${index + 1}'),
                  selected: _selectedItemIndex == index,
                  onSelected: (value) {
                    setState(() {
                      _selectedItemIndex = index;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 12.0),
            Wrap(
              spacing: 6.0,
              children: List.generate(3, (index) {
                return ChoiceChip(
                  label: Text(
                    'Item ${index + 1}',
                  ),
                  selected: _selectedItemIndex == index,
                  onSelected: null,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
