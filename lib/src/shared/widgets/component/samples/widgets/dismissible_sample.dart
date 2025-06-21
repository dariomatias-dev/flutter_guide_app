import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DismissibleSample(),
    ),
  );
}

class DismissibleSample extends StatelessWidget {
  const DismissibleSample({super.key});

  ListTile get _listTile => const ListTile(
        title: Text('Title'),
        subtitle: Text('Subtitle'),
        trailing: Icon(
          Icons.swap_horiz,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Dismissible(
            key: GlobalKey(),
            onDismissed: (direction) {},
            background: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(2, (index) {
                  return const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  );
                }),
              ),
            ),
            child: _listTile,
          ),
          Dismissible(
            key: GlobalKey(),
            onDismissed: (direction) {},
            background: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              color: Colors.red,
              child: const Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              color: Colors.blue,
              child: const Icon(
                Icons.move_to_inbox_rounded,
                color: Colors.white,
              ),
            ),
            child: _listTile,
          ),
        ],
      ),
    );
  }
}
