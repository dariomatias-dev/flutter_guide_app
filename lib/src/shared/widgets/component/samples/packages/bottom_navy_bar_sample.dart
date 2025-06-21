import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

const _screenNames = <String>[
  'Home',
  'Profile',
  'Settings',
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavyBarSample(),
    ),
  );
}

class BottomNavyBarSample extends StatefulWidget {
  const BottomNavyBarSample({super.key});

  @override
  State<BottomNavyBarSample> createState() => _BottomNavyBarSampleState();
}

class _BottomNavyBarSampleState extends State<BottomNavyBarSample> {
  int _screenIndex = 0;

  void _updateScreenIndex(int value) {
    setState(() {
      _screenIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _screenNames[_screenIndex],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _screenIndex,
        onItemSelected: _updateScreenIndex,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}
