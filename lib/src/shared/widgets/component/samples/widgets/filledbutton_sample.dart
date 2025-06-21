import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FilledButtonSample(),
    ),
  );
}

class FilledButtonSample extends StatelessWidget {
  const FilledButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('FilledButton'),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FilledButton(
                  onPressed: () {},
                  child: const Text('Enabled'),
                ),
                const SizedBox(width: 12.0),
                const FilledButton(
                  onPressed: null,
                  child: Text('Disabled'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text('FilledButton.tonal'),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FilledButton.tonal(
                  onPressed: () {},
                  child: const Text('Enabled'),
                ),
                const SizedBox(width: 12.0),
                const FilledButton.tonal(
                  onPressed: null,
                  child: Text('Disabled'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text('FilledButton.icon'),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: () {},
                  label: const Text('Enabled'),
                  icon: const Icon(Icons.add),
                ),
                const SizedBox(width: 12.0),
                FilledButton.icon(
                  onPressed: null,
                  label: const Text('Disabled'),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text('FilledButton.tonalIcon'),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FilledButton.tonalIcon(
                  onPressed: () {},
                  label: const Text('Enabled'),
                  icon: const Icon(Icons.add),
                ),
                const SizedBox(width: 12.0),
                FilledButton.tonalIcon(
                  onPressed: null,
                  label: const Text('Disabled'),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
