import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SliderSample(),
    ),
  );
}

/// Sample demonstrating `SliderSample`.
class SliderSample extends StatelessWidget {
  /// Creates a [SliderSample].
  const SliderSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SliderTemplate(
                  title: 'Standard',
                ),
                Divider(),
                SliderTemplate(
                  title: '0 to 100 without divisions',
                  max: 100,
                ),
                Divider(),
                SliderTemplate(
                  title: '50 to 100 with 50 divisions',
                  min: 50,
                  max: 100,
                  divisions: 50,
                ),
                Divider(),
                SliderTemplate(
                  title: '0 to 100 with 20 divisions',
                  max: 100,
                  divisions: 20,
                ),
                Divider(),
                SliderTemplate(
                  title: '0 to 100 with 100 divisions',
                  max: 100,
                  divisions: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Sample demonstrating `SliderTemplate`.
class SliderTemplate extends StatefulWidget {
  const SliderTemplate({
    required this.title, super.key,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
  });

  final String title;
  final double min;
  final double max;
  final int? divisions;

  @override
  State<SliderTemplate> createState() => _SliderTemplateState();
}

class _SliderTemplateState extends State<SliderTemplate> {
  bool _showFloatingPoint = true;
  double _value = 0;

  @override
  void initState() {
    _value = widget.min;

    if (widget.divisions != null) {
      final divisionResult = widget.max / widget.divisions!;
      _showFloatingPoint = divisionResult != divisionResult.floor();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          (_showFloatingPoint ? _value : _value.floor()).toString(),
        ),
        Slider(
          value: _value,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    );
  }
}
