import 'package:flutter/material.dart';

const _fruits = <String>[
  'Apple',
  'Banana',
  'Cherry',
  'Grape',
  'Mango',
  'Orange',
  'Peach',
  'Strawberry',
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchBarSample(),
    ),
  );
}

/// Sample demonstrating `SearchBarSample`.
class SearchBarSample extends StatefulWidget {
  /// Creates a [SearchBarSample].
  const SearchBarSample({super.key});

  @override
  State<SearchBarSample> createState() => _SearchBarSampleState();
}

class _SearchBarSampleState extends State<SearchBarSample> {
  String? _selectedFruit;
  final _standaloneController = TextEditingController();
  final _searchController = SearchController();

  @override
  void initState() {
    super.initState();
    _standaloneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _standaloneController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Widget> _buildSuggestions(SearchController controller) {
    final query = controller.text.toLowerCase();
    final results = query.isEmpty
        ? _fruits
        : _fruits.where((fruit) => fruit.toLowerCase().contains(query));

    if (results.isEmpty) {
      return const <Widget>[
        ListTile(
          title: Text('No results found'),
        ),
      ];
    }

    return results
        .map(
          (fruit) => ListTile(
            title: Text(fruit),
            onTap: () {
              setState(() {
                _selectedFruit = fruit;
              });
              controller.closeView(fruit);
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const Text('Standalone SearchBar with clear button'),
            const SizedBox(height: 8),
            SearchBar(
              controller: _standaloneController,
              hintText: 'Search fruits',
              leading: const Icon(Icons.search),
              trailing: <Widget>[
                if (_standaloneController.text.isNotEmpty)
                  IconButton(
                    tooltip: 'Clear',
                    icon: const Icon(Icons.clear),
                    onPressed: _standaloneController.clear,
                  ),
              ],
              onSubmitted: (value) {
                setState(() {
                  _selectedFruit = value;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text('SearchAnchor with suggestions'),
            const SizedBox(height: 8),
            SearchAnchor(
              searchController: _searchController,
              builder: (context, controller) {
                return SearchBar(
                  controller: controller,
                  hintText: 'Search fruits',
                  leading: const Icon(Icons.search),
                  onTap: controller.openView,
                  onChanged: (_) => controller.openView(),
                );
              },
              suggestionsBuilder: (context, controller) {
                return _buildSuggestions(controller);
              },
            ),
            const SizedBox(height: 24),
            const Text('Styled SearchBar (color, elevation, constraints)'),
            const SizedBox(height: 8),
            SearchBar(
              hintText: 'Search fruits',
              leading: const Icon(Icons.search),
              constraints: const BoxConstraints(minHeight: 40, maxWidth: 240),
              elevation: const WidgetStatePropertyAll(4),
              backgroundColor: WidgetStatePropertyAll(
                colorScheme.primaryContainer,
              ),
              textStyle: WidgetStatePropertyAll(
                TextStyle(color: colorScheme.onPrimaryContainer),
              ),
              onSubmitted: (value) {
                setState(() {
                  _selectedFruit = value;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text('Disabled SearchBar'),
            const SizedBox(height: 8),
            const SearchBar(
              hintText: 'Search fruits',
              leading: Icon(Icons.search),
              enabled: false,
            ),
            const SizedBox(height: 24),
            Text('Selected: ${_selectedFruit ?? '-'}'),
          ],
        ),
      ),
    );
  }
}
