import 'package:flutter/material.dart';

class _PersonModel {
  const _PersonModel({
    required this.name,
    required this.age,
    required this.city,
    required this.role,
  });

  final String name;
  final String age;
  final String city;
  final String role;
}

const _people = <_PersonModel>[
  _PersonModel(name: 'Alice', age: '24', city: 'New York', role: 'Designer'),
  _PersonModel(name: 'Bob', age: '30', city: 'London', role: 'Developer'),
  _PersonModel(name: 'Carol', age: '28', city: 'Berlin', role: 'Manager'),
  _PersonModel(name: 'David', age: '35', city: 'Tokyo', role: 'Developer'),
];

/// TableCellVerticalAlignment
class _VerticalAlignmentModel {
  const _VerticalAlignmentModel({
    required this.name,
    required this.alignment,
  });

  /// The [name].
  final String name;

  /// The [alignment].
  final TableCellVerticalAlignment alignment;
}

const _verticalAlignments = <_VerticalAlignmentModel>[
  _VerticalAlignmentModel(
    name: 'Top',
    alignment: TableCellVerticalAlignment.top,
  ),
  _VerticalAlignmentModel(
    name: 'Middle',
    alignment: TableCellVerticalAlignment.middle,
  ),
  _VerticalAlignmentModel(
    name: 'Bottom',
    alignment: TableCellVerticalAlignment.bottom,
  ),
];

final List<DropdownMenuItem<TableCellVerticalAlignment>>
    _verticalAlignmentItems = List.generate(
  _verticalAlignments.length,
  (index) {
    final verticalAlignment = _verticalAlignments[index];

    return DropdownMenuItem(
      value: verticalAlignment.alignment,
      child: Text(
        verticalAlignment.name,
      ),
    );
  },
);

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TableSample(),
    ),
  );
}

/// Sample demonstrating `TableSample`.
class TableSample extends StatefulWidget {
  /// Creates a [TableSample].
  const TableSample({super.key});

  @override
  State<TableSample> createState() => _TableSampleState();
}

class _TableSampleState extends State<TableSample> {
  TableCellVerticalAlignment _verticalAlignment =
      TableCellVerticalAlignment.middle;
  bool _showZebraStripes = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final headerColor = colorScheme.primaryContainer;
    final stripeColor = colorScheme.surfaceContainerHighest;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Table(
          border: TableBorder.all(
            color: colorScheme.outlineVariant,
          ),
          defaultVerticalAlignment: _verticalAlignment,
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(60),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(),
            3: FlexColumnWidth(2),
          },
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: headerColor),
              children: const <Widget>[
                SizedBox(),
                _TableCellText('Name', isHeader: true),
                _TableCellText('Age', isHeader: true),
                _TableCellText('City / Role', isHeader: true),
              ],
            ),
            for (var i = 0; i < _people.length; i++)
              TableRow(
                decoration: _showZebraStripes && i.isOdd
                    ? BoxDecoration(color: stripeColor)
                    : null,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: CircleAvatar(
                        radius: 20,
                        child: Text(_people[i].name[0]),
                      ),
                    ),
                  ),
                  _TableCellText(_people[i].name),
                  _TableCellText(_people[i].age),
                  _TableCellText('${_people[i].city}\n${_people[i].role}'),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Column(
          children: <Widget>[
            const Divider(),
            const Text('defaultVerticalAlignment'),
            DropdownButton<TableCellVerticalAlignment>(
              value: _verticalAlignment,
              items: _verticalAlignmentItems,
              onChanged: (value) {
                setState(() {
                  _verticalAlignment = value!;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Zebra stripes'),
              value: _showZebraStripes,
              onChanged: (value) {
                setState(() {
                  _showZebraStripes = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TableCellText extends StatelessWidget {
  const _TableCellText(
    this.text, {
    this.isHeader = false,
  });

  final String text;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
