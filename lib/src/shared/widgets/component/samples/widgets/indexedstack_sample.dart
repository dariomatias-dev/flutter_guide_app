import 'package:flutter/material.dart';


const _colors = <Color>[
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.green,
  Colors.purple,
];

final items = List.generate(5, (index) {
  return 'Item ${index + 1}';
});

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexedStackSample(),
    ),
  );
}

class IndexedStackSample extends StatefulWidget {
  const IndexedStackSample({super.key});

  @override
  State<IndexedStackSample> createState() => _IndexedStackSampleState();
}

class _IndexedStackSampleState extends State<IndexedStackSample> {
  int _itemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IndexedStack(
              index: _itemIndex,
              children: List.generate(_colors.length, (index) {
                return Container(
                  height: 160.0,
                  color: _colors[index],
                  child: Center(
                    child: Text(
                      'Item ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20.0),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _itemIndex,
                items: List.generate(items.length, (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Text(items[index]),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _itemIndex = value as int;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
