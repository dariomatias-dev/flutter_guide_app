import 'package:flutter/material.dart';

class _PersonModel {
  const _PersonModel({
    required this.name,
    required this.age,
    required this.role,
  });

  final String name;
  final int age;
  final String role;
}

const _roleColors = <String, Color>{
  'Designer': Colors.purple,
  'Developer': Colors.blue,
  'Manager': Colors.orange,
};

final _people = <_PersonModel>[
  const _PersonModel(name: 'Alice', age: 24, role: 'Designer'),
  const _PersonModel(name: 'Bob', age: 30, role: 'Developer'),
  const _PersonModel(name: 'Carol', age: 28, role: 'Manager'),
  const _PersonModel(name: 'David', age: 35, role: 'Developer'),
  const _PersonModel(name: 'Erin', age: 27, role: 'Designer'),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataTableSample(),
    ),
  );
}

/// Sample demonstrating `DataTable`.
class DataTableSample extends StatefulWidget {
  /// Creates a [DataTableSample].
  const DataTableSample({super.key});

  @override
  State<DataTableSample> createState() => _DataTableSampleState();
}

class _DataTableSampleState extends State<DataTableSample> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  String _query = '';
  final Set<_PersonModel> _selected = <_PersonModel>{};

  void _sort<T>(
    Comparable<T> Function(_PersonModel person) getField,
    int columnIndex,
    bool ascending,
  ) {
    _people.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void _deleteSelected() {
    setState(() {
      _people.removeWhere(_selected.contains);
      _selected.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.toLowerCase();
    final filtered = _people
        .where((person) => person.name.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
        actions: [
          if (_selected.isNotEmpty)
            IconButton(
              tooltip: 'Delete selected',
              icon: Badge(
                label: Text('${_selected.length}'),
                child: const Icon(Icons.delete_outline),
              ),
              onPressed: _deleteSelected,
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No people found'))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: <DataColumn>[
                        DataColumn(
                          label: const Text('Name'),
                          onSort: (columnIndex, ascending) => _sort<String>(
                            (person) => person.name,
                            columnIndex,
                            ascending,
                          ),
                        ),
                        DataColumn(
                          label: const Text('Age'),
                          numeric: true,
                          onSort: (columnIndex, ascending) => _sort<num>(
                            (person) => person.age,
                            columnIndex,
                            ascending,
                          ),
                        ),
                        DataColumn(
                          label: const Text('Role'),
                          onSort: (columnIndex, ascending) => _sort<String>(
                            (person) => person.role,
                            columnIndex,
                            ascending,
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        for (final person in filtered)
                          DataRow(
                            selected: _selected.contains(person),
                            onSelectChanged: (selected) {
                              setState(() {
                                if (selected ?? false) {
                                  _selected.add(person);
                                } else {
                                  _selected.remove(person);
                                }
                              });
                            },
                            cells: <DataCell>[
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 14,
                                      child: Text(person.name[0]),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(person.name),
                                  ],
                                ),
                              ),
                              DataCell(Text('${person.age}')),
                              DataCell(
                                Chip(
                                  label: Text(person.role),
                                  backgroundColor: _roleColors[person.role]
                                      ?.withValues(alpha: 0.15),
                                  side: BorderSide.none,
                                  labelStyle: TextStyle(
                                    color: _roleColors[person.role],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
