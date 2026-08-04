import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RefreshIndicatorSample(),
    ),
  );
}

/// Sample demonstrating `RefreshIndicator`.
class RefreshIndicatorSample extends StatefulWidget {
  /// Creates a [RefreshIndicatorSample].
  const RefreshIndicatorSample({super.key});

  @override
  State<RefreshIndicatorSample> createState() => _RefreshIndicatorSampleState();
}

class _RefreshIndicatorSampleState extends State<RefreshIndicatorSample> {
  var _refreshCount = 0;

  Future<void> _handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (!mounted) {
      return;
    }

    setState(() {
      _refreshCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                title: Text('Refreshed $_refreshCount time(s)'),
              );
            }

            return ListTile(title: Text('Item $index'));
          },
        ),
      ),
    );
  }
}
