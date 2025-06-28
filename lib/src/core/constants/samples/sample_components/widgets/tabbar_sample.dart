import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarSample(),
    ),
  );
}

class TabBarSample extends StatefulWidget {
  const TabBarSample({super.key});

  @override
  State<TabBarSample> createState() => _TabBarSampleState();
}

class _TabBarSampleState extends State<TabBarSample> {
  int _tabIndex = 0;

  final _tabs = <Tab>[
    const Tab(
      icon: Icon(
        Icons.person,
      ),
    ),
    const Tab(
      icon: Icon(
        Icons.file_download_outlined,
      ),
    ),
    const Tab(
      icon: Icon(
        Icons.settings,
      ),
    ),
  ];

  final bodyTexts = <String>[
    'Person',
    'Download',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text('TabBar'),
          centerTitle: true,
          bottom: TabBar(
            onTap: (value) {
              setState(() {
                _tabIndex = value;
              });
            },
            tabs: _tabs,
          ),
        ),
        body: Center(
          child: Text(
            bodyTexts[_tabIndex],
          ),
        ),
      ),
    );
  }
}
