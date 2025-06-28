import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListTileSample(),
    ),
  );
}

class ListTileSample extends StatelessWidget {
  const ListTileSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            trailing: Icon(
              Icons.arrow_right,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.info),
            title: const Text('Title'),
            subtitle: const Text('Subtitle'),
            trailing: const Icon(
              Icons.arrow_right,
            ),
          ),
        ],
      ),
    );
  }
}
