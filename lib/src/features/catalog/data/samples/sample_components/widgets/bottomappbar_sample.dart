import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomAppBarSample(),
    ),
  );
}

class BottomAppBarSample extends StatelessWidget {
  const BottomAppBarSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text('Body'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: SizedBox(
        height: 88.0,
        child: BottomAppBar(
          padding: const EdgeInsets.only(
            top: 12.0,
            right: 16.0,
            left: 16.0,
          ),
          color: Colors.blue,
          child: IconTheme(
            data: IconThemeData(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.home,
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person,
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
