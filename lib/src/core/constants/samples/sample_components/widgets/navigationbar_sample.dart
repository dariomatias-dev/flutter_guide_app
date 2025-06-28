import 'package:flutter/material.dart';

const _screens = <String>[
  'Home Screen',
  'Profile Screen',
  'Settings Screen',
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationBarSample(),
    ),
  );
}

class NavigationBarSample extends StatefulWidget {
  const NavigationBarSample({super.key});

  @override
  State<NavigationBarSample> createState() => _NavigationBarSampleState();
}

class _NavigationBarSampleState extends State<NavigationBarSample> {
  int _selectedScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _screens[_selectedScreenIndex],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedScreenIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedScreenIndex = value;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
