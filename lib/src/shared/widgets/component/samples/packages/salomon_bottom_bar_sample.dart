import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar_extend/salomon_bottom_bar.dart';

const _screenNames = <String>[
  'Home',
  'Profile',
  'Settings',
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SalomonBottomBarSample(),
    ),
  );
}

class SalomonBottomBarSample extends StatefulWidget {
  const SalomonBottomBarSample({super.key});

  @override
  State<SalomonBottomBarSample> createState() => _SalomonBottomBarSampleState();
}

class _SalomonBottomBarSampleState extends State<SalomonBottomBarSample> {
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
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _screenIndex,
        onTap: _updateScreenIndex,
        items: <SalomonBottomBarItem>[
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
