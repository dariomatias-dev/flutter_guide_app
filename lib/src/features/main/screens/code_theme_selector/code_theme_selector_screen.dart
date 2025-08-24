import 'package:flutter/material.dart';

class CodeThemeSelectorScreen extends StatelessWidget {
  const CodeThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Code Theme Selector',
          ),
        ),
      ),
    );
  }
}
