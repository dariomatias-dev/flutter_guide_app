import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ThemeSample(),
    ),
  );
}

class ThemeSample extends StatefulWidget {
  const ThemeSample({super.key});

  @override
  State<ThemeSample> createState() => _ThemeSampleState();
}

class _ThemeSampleState extends State<ThemeSample> {
  ThemeData _theme = ThemeData.light();

  void _toggleTheme() {
    setState(() {
      _theme =
          _theme == ThemeData.light() ? ThemeData.dark() : ThemeData.light();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _theme,
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _toggleTheme,
            child: const Text('Toggle Theme'),
          ),
        ),
      ),
    );
  }
}
