import 'dart:async';

import 'package:flutter/material.dart';

const _fruits = <String>[
  'Apple',
  'Banana',
  'Cherry',
  'Grape',
  'Mango',
  'Orange',
];

class _FruitSearchDelegate extends SearchDelegate<String?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Widget _buildList(BuildContext context) {
    final results = query.isEmpty
        ? _fruits
        : _fruits.where(
            (fruit) => fruit.toLowerCase().contains(query.toLowerCase()),
          );

    return ListView(
      children: results
          .map(
            (fruit) => ListTile(
              title: Text(fruit),
              onTap: () {
                close(context, fruit);
              },
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowSearchSample(),
    ),
  );
}

/// Sample demonstrating `ShowSearchSample`.
class ShowSearchSample extends StatefulWidget {
  /// Creates a [ShowSearchSample].
  const ShowSearchSample({super.key});

  @override
  State<ShowSearchSample> createState() => _ShowSearchSampleState();
}

class _ShowSearchSampleState extends State<ShowSearchSample> {
  String? _selectedFruit;

  void _showSearch() {
    unawaited(
      showSearch<String?>(
        context: context,
        delegate: _FruitSearchDelegate(),
      ).then((value) {
        setState(() {
          _selectedFruit = value;
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showSearch,
              child: const Text('Show Search'),
            ),
            const SizedBox(height: 12),
            Text('Selected: ${_selectedFruit ?? '-'}'),
          ],
        ),
      ),
    );
  }
}
