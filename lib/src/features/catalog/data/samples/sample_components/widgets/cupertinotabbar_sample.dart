import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoTabBarSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoTabBarSample`.
class CupertinoTabBarSample extends StatefulWidget {
  /// Creates a [CupertinoTabBarSample].
  const CupertinoTabBarSample({super.key});

  @override
  State<CupertinoTabBarSample> createState() => _CupertinoTabBarSampleState();
}

class _CupertinoTabBarSampleState extends State<CupertinoTabBarSample> {
  int _currentIndex = 0;

  static const _titles = <String>['Home', 'Search', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text('${_titles[_currentIndex]} content'),
            ),
          ),
          CupertinoTabBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
