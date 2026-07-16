import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoSearchTextFieldSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoSearchTextFieldSample`.
class CupertinoSearchTextFieldSample extends StatefulWidget {
  /// Creates a [CupertinoSearchTextFieldSample].
  const CupertinoSearchTextFieldSample({super.key});

  @override
  State<CupertinoSearchTextFieldSample> createState() =>
      _CupertinoSearchTextFieldSampleState();
}

class _CupertinoSearchTextFieldSampleState
    extends State<CupertinoSearchTextFieldSample> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoSearchTextField(
                placeholder: 'Search fruits',
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('Query: ${_query.isEmpty ? '-' : _query}'),
            ],
          ),
        ),
      ),
    );
  }
}
