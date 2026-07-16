import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoTextFieldSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoTextFieldSample`.
class CupertinoTextFieldSample extends StatelessWidget {
  /// Creates a [CupertinoTextFieldSample].
  const CupertinoTextFieldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CupertinoTextField(
                placeholder: 'Standard',
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                placeholder: 'With prefix icon',
                prefix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(CupertinoIcons.person),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 20),
              const CupertinoTextField(
                placeholder: 'Obscured',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              const CupertinoTextField(
                placeholder: 'Disabled',
                enabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
