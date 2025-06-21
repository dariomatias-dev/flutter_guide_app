import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToggleButtonsSample(),
    ),
  );
}

class ToggleButtonsSample extends StatefulWidget {
  const ToggleButtonsSample({super.key});

  @override
  State<ToggleButtonsSample> createState() => _ToggleButtonsSampleState();
}

class _ToggleButtonsSampleState extends State<ToggleButtonsSample> {
  List<bool> values = List.filled(3, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ToggleButtons(
              onPressed: (index) {
                setState(() {
                  values[index] = !values[index];
                });
              },
              isSelected: values,
              children: <Icon>[
                Icon(
                  values[0] ? Icons.g_translate : Icons.g_translate_outlined,
                ),
                Icon(
                  values[1] ? Icons.favorite : Icons.favorite_border,
                ),
                Icon(
                  values[2] ? Icons.access_alarm_outlined : Icons.alarm_off,
                ),
              ],
            ),
            ToggleButtons(
              isSelected: values,
              children: <Icon>[
                Icon(
                  values[0] ? Icons.g_translate : Icons.g_translate_outlined,
                ),
                Icon(
                  values[1] ? Icons.favorite : Icons.favorite_border,
                ),
                Icon(
                  values[2] ? Icons.access_alarm_outlined : Icons.alarm_off,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
