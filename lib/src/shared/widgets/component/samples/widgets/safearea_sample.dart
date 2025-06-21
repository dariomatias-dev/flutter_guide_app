import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeAreaSample(),
    ),
  );
}

class SafeAreaSample extends StatefulWidget {
  const SafeAreaSample({super.key});

  @override
  State<SafeAreaSample> createState() => _SafeAreaSampleState();
}

class _SafeAreaSampleState extends State<SafeAreaSample> {
  void _showWithSafeArea() {
    _navigateTo(
      const WithSafeArea(),
    );
  }

  void _showWithoutSafeArea() {
    _navigateTo(
      const WithoutSafeArea(),
    );
  }

  void _navigateTo(
    Widget screen,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 12.0,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showWithSafeArea,
              child: const Text(
                'Screen With SafeArea',
              ),
            ),
            ElevatedButton(
              onPressed: _showWithoutSafeArea,
              child: const Text(
                'Screen Without SafeArea',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WithSafeArea extends StatelessWidget {
  const WithSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Text(
              'Screen With SafeArea',
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WithoutSafeArea extends StatelessWidget {
  const WithoutSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text(
            'Screen Without SafeArea',
          ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
