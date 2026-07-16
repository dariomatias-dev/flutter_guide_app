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

const _people = <_PersonModel>[
  _PersonModel(name: 'Alice', age: 24, role: 'Designer'),
  _PersonModel(name: 'Bob', age: 30, role: 'Developer'),
  _PersonModel(name: 'Carol', age: 28, role: 'Manager'),
  _PersonModel(name: 'David', age: 35, role: 'Developer'),
  _PersonModel(name: 'Erin', age: 27, role: 'Designer'),
  _PersonModel(name: 'Frank', age: 40, role: 'Manager'),
  _PersonModel(name: 'Grace', age: 33, role: 'Developer'),
  _PersonModel(name: 'Heidi', age: 29, role: 'Designer'),
];

class _PeopleDataSource extends DataTableSource {
  _PeopleDataSource({required this.onSelectionChanged});

  final VoidCallback onSelectionChanged;
  final Set<_PersonModel> selected = <_PersonModel>{};
  List<_PersonModel> rows = _people;

  void updateRows(List<_PersonModel> newRows) {
    rows = newRows;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    final person = rows[index];

    return DataRow.byIndex(
      index: index,
      selected: selected.contains(person),
      onSelectChanged: (isSelected) {
        if (isSelected ?? false) {
          selected.add(person);
        } else {
          selected.remove(person);
        }
        onSelectionChanged();
        notifyListeners();
      },
      cells: <DataCell>[
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 14, child: Text(person.name[0])),
              const SizedBox(width: 12),
              Text(person.name),
            ],
          ),
        ),
        DataCell(Text('${person.age}')),
        DataCell(
          Chip(
            label: Text(person.role),
            backgroundColor: _roleColors[person.role]?.withValues(alpha: 0.15),
            side: BorderSide.none,
            labelStyle: TextStyle(color: _roleColors[person.role]),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => rows.length;

  @override
  int get selectedRowCount => selected.length;
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginatedDataTableSample(),
    ),
  );
}

/// Sample demonstrating `PaginatedDataTable`.
class PaginatedDataTableSample extends StatefulWidget {
  /// Creates a [PaginatedDataTableSample].
  const PaginatedDataTableSample({super.key});

  @override
  State<PaginatedDataTableSample> createState() =>
      _PaginatedDataTableSampleState();
}

class _PaginatedDataTableSampleState extends State<PaginatedDataTableSample> {
  late final _dataSource = _PeopleDataSource(
    onSelectionChanged: () => setState(() {}),
  );
  int _rowsPerPage = 4;

  void _applyQuery(String query) {
    final lower = query.toLowerCase();
    setState(() {
      _dataSource.updateRows(
        _people
            .where((person) => person.name.toLowerCase().contains(lower))
            .toList(),
      );
    });
  }

  void _deleteSelected() {
    final remaining = _dataSource.rows
        .where((person) => !_dataSource.selected.contains(person))
        .toList();
    setState(() {
      _dataSource.selected.clear();
      _dataSource.updateRows(remaining);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
        actions: [
          if (_dataSource.selected.isNotEmpty)
            IconButton(
              tooltip: 'Delete selected',
              icon: Badge(
                label: Text('${_dataSource.selected.length}'),
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
              onChanged: _applyQuery,
            ),
          ),
          Expanded(
            child: _dataSource.rows.isEmpty
                ? const Center(child: Text('No people found'))
                : PaginatedDataTable(
                    key: ValueKey(_rowsPerPage),
                    rowsPerPage: _rowsPerPage,
                    availableRowsPerPage: const [4, 6, 8],
                    onRowsPerPageChanged: (value) {
                      setState(() {
                        _rowsPerPage = value ?? _rowsPerPage;
                      });
                    },
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Age'), numeric: true),
                      DataColumn(label: Text('Role')),
                    ],
                    source: _dataSource,
                  ),
          ),
        ],
      ),
    );
  }
}
