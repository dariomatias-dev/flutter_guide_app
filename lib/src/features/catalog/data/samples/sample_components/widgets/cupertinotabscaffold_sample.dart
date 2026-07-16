import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoTabScaffoldSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoTabScaffoldSample`.
class CupertinoTabScaffoldSample extends StatelessWidget {
  /// Creates a [CupertinoTabScaffoldSample].
  const CupertinoTabScaffoldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
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
      tabBuilder: (context, index) {
        final titles = <String>['Home', 'Search', 'Settings'];

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(titles[index]),
          ),
          child: Center(
            child: Text('${titles[index]} tab'),
          ),
        );
      },
    );
  }
}
