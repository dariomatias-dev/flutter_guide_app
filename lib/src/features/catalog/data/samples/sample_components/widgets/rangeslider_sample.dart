import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RangeSliderSample(),
    ),
  );
}

/// Sample demonstrating `RangeSliderSample`.
class RangeSliderSample extends StatelessWidget {
  /// Creates a [RangeSliderSample].
  const RangeSliderSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RangeSliderTemplate(
                title: 'Standard',
              ),
              Divider(),
              RangeSliderTemplate(
                title: '0 to 100 without divisions',
                max: 100,
              ),
              Divider(),
              RangeSliderTemplate(
                title: '50 to 100 with 50 divisions',
                min: 50,
                max: 100,
                divisions: 50,
              ),
              Divider(),
              RangeSliderTemplate(
                title: '0 to 100 with 20 divisions',
                max: 100,
                divisions: 20,
              ),
              Divider(),
              RangeSliderTemplate(
                title: '0 to 100 with 100 divisions',
                max: 100,
                divisions: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sample demonstrating `RangeSliderTemplate`.
class RangeSliderTemplate extends StatefulWidget {
  /// Creates a [RangeSliderTemplate].
  const RangeSliderTemplate({
    required this.title,
    super.key,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
  });

  /// The [title].
  final String title;

  /// The [min].
  final double min;

  /// The [max].
  final double max;

  /// The [divisions].
  final int? divisions;

  @override
  State<RangeSliderTemplate> createState() => _RangeSliderTemplateState();
}

class _RangeSliderTemplateState extends State<RangeSliderTemplate> {
  bool _showFloatingPoint = true;
  RangeValues _values = const RangeValues(
    0,
    1,
  );

  @override
  void initState() {
    _values = RangeValues(
      widget.min,
      widget.max,
    );

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
          '${_showFloatingPoint ? _values.start : _values.start.floor()}'
          ' - '
          '${_showFloatingPoint ? _values.end : _values.end.floor()}',
        ),
        RangeSlider(
          values: _values,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          onChanged: (value) {
            setState(() {
              _values = value;
            });
          },
        ),
      ],
    );
  }
}
