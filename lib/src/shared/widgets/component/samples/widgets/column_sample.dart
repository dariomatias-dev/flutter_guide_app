import 'package:flutter/material.dart';

const _colors = <Color>[
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

final _columnItems = List.generate(_colors.length, (index) {
  return Container(
    width: 50.0,
    height: 50.0,
    color: _colors[index],
  );
});

/// MainAxisAlignment
class _MainAxisAlignmentModel {
  const _MainAxisAlignmentModel({
    required this.name,
    required this.mainAxisAlignment,
  });

  final String name;
  final MainAxisAlignment mainAxisAlignment;
}

const _mainAxisAlignments = <_MainAxisAlignmentModel>[
  _MainAxisAlignmentModel(
    name: 'Center',
    mainAxisAlignment: MainAxisAlignment.center,
  ),
  _MainAxisAlignmentModel(
    name: 'End',
    mainAxisAlignment: MainAxisAlignment.end,
  ),
  _MainAxisAlignmentModel(
    name: 'SpaceAround',
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ),
  _MainAxisAlignmentModel(
    name: 'SpaceBetween',
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
  ),
  _MainAxisAlignmentModel(
    name: 'SpaceEvenly',
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  ),
  _MainAxisAlignmentModel(
    name: 'Start',
    mainAxisAlignment: MainAxisAlignment.start,
  ),
];

final _mainAxisAlignmentItems = List.generate(
  _mainAxisAlignments.length,
  (index) {
    final mainAxisAlignment = _mainAxisAlignments[index];

    return DropdownMenuItem(
      value: mainAxisAlignment.mainAxisAlignment,
      child: Text(
        mainAxisAlignment.name,
      ),
    );
  },
);

/// MainAxisSize
class _MainAxisSizeModel {
  const _MainAxisSizeModel({
    required this.name,
    required this.mainAxisSize,
  });

  final String name;
  final MainAxisSize mainAxisSize;
}

const _mainAxisSizes = <_MainAxisSizeModel>[
  _MainAxisSizeModel(
    name: 'Max',
    mainAxisSize: MainAxisSize.max,
  ),
  _MainAxisSizeModel(
    name: 'Min',
    mainAxisSize: MainAxisSize.min,
  ),
];

final _mainAxisSizeItems = List.generate(
  _mainAxisSizes.length,
  (index) {
    final mainAxisSize = _mainAxisSizes[index];

    return DropdownMenuItem(
      value: mainAxisSize.mainAxisSize,
      child: Text(
        mainAxisSize.name,
      ),
    );
  },
);

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ColumnSample(),
    ),
  );
}

class ColumnSample extends StatefulWidget {
  const ColumnSample({super.key});

  @override
  State<ColumnSample> createState() => _ColumnSampleState();
}

class _ColumnSampleState extends State<ColumnSample> {
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.center;
  MainAxisSize _mainAxisSize = MainAxisSize.max;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: _mainAxisAlignment,
            mainAxisSize: _mainAxisSize,
            children: _columnItems,
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 180.0,
        child: Column(
          children: <Widget>[
            const Divider(),
            const Text('MainAxisAlignment'),
            DropdownButton<MainAxisAlignment>(
              value: _mainAxisAlignment,
              items: _mainAxisAlignmentItems,
              onChanged: (value) {
                setState(() {
                  _mainAxisAlignment = value!;
                });
              },
            ),
            const SizedBox(height: 20.0),
            const Text('MainAxisSize'),
            DropdownButton<MainAxisSize>(
              value: _mainAxisSize,
              items: _mainAxisSizeItems,
              onChanged: (value) {
                setState(() {
                  _mainAxisSize = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
