import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchAnchorSample(),
    ),
  );
}

/// Sample demonstrating `SearchAnchor`.
class SearchAnchorSample extends StatelessWidget {
  /// Creates a [SearchAnchorSample].
  const SearchAnchorSample({super.key});

  static const _fruits = <String>[
    'Apple',
    'Banana',
    'Cherry',
    'Grape',
    'Mango',
    'Orange',
    'Peach',
    'Strawberry',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SearchAnchor(
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
              final query = controller.text.toLowerCase();
              final results = _fruits.where(
                (fruit) => fruit.toLowerCase().contains(query),
              );

              return <Widget>[
                for (final fruit in results)
                  ListTile(
                    title: Text(fruit),
                    onTap: () => controller.closeView(fruit),
                  ),
              ];
            },
          ),
        ),
      ),
    );
  }
}
