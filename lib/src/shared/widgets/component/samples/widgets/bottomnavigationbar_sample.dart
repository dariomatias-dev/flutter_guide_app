import 'package:flutter/material.dart';

class BottomNavigationBarSample extends StatefulWidget {
  const BottomNavigationBarSample({super.key});

  @override
  State<BottomNavigationBarSample> createState() =>
      _BottomNavigationBarSampleState();
}

class _BottomNavigationBarSampleState extends State<BottomNavigationBarSample> {
  final _options = <String>[
    'Home',
    'Profile',
    'Settings',
  ];

  int _selectedOption = 0;

  void _updateSelectedOption(int value) {
    setState(() {
      _selectedOption = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '${_options.elementAt(
            _selectedOption,
          )} Screen',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedOption,
        onTap: _updateSelectedOption,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
