import 'package:flutter/material.dart';

/// A named period option shown in the [ChoosePeriodWidget].
class PeriodModel {
  /// Creates a [PeriodModel].
  const PeriodModel({
    required this.name,
    required this.iconData,
  });

  /// Display name of the period.
  final String name;

  /// Icon representing the period.
  final IconData iconData;
}

const _periods = <PeriodModel>[
  PeriodModel(
    name: 'Day',
    iconData: Icons.calendar_view_day,
  ),
  PeriodModel(
    name: 'Week',
    iconData: Icons.calendar_view_week,
  ),
  PeriodModel(
    name: 'Month',
    iconData: Icons.calendar_view_month,
  ),
  PeriodModel(
    name: 'Year',
    iconData: Icons.calendar_today,
  ),
];

/// Colors demonstrated by [ChooseColorsWidget].
enum Color {
  /// Blue.
  blue,

  /// Green.
  green,

  /// Red.
  red,
}

final _colors = <Color>[
  Color.red,
  Color.blue,
  Color.green,
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SegmentedButtonSample(),
    ),
  );
}

/// Sample demonstrating `SegmentedButton`.
class SegmentedButtonSample extends StatefulWidget {
  /// Creates a [SegmentedButtonSample].
  const SegmentedButtonSample({super.key});

  @override
  State<SegmentedButtonSample> createState() => _SegmentedButtonSampleState();
}

class _SegmentedButtonSampleState extends State<SegmentedButtonSample> {
  final ValueNotifier<PeriodModel> _periodSelected = ValueNotifier(
    _periods.first,
  );
  final ValueNotifier<Set<Color>> _colorSelected = ValueNotifier(
    <Color>{_colors.first},
  );

  TextStyle get _defaultTextStyle => const TextStyle(
        fontSize: 12,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: _periodSelected,
              builder: (context, value, child) {
                return Column(
                  children: <Widget>[
                    ChoosePeriodWidget(
                      periodSelected: _periodSelected,
                      defaultTextStyle: _defaultTextStyle,
                    ),
                    const SizedBox(height: 12),
                    ChoosePeriodWidget(
                      periodSelected: _periodSelected,
                      disabled: true,
                      defaultTextStyle: _defaultTextStyle,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            ValueListenableBuilder(
              valueListenable: _colorSelected,
              builder: (context, value, child) {
                return Column(
                  children: <Widget>[
                    ChooseColorsWidget(
                      colorSelected: _colorSelected,
                      defaultTextStyle: _defaultTextStyle,
                    ),
                    const SizedBox(height: 12),
                    ChooseColorsWidget(
                      colorSelected: _colorSelected,
                      disabled: true,
                      defaultTextStyle: _defaultTextStyle,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Single-select [SegmentedButton] over the available periods.
class ChoosePeriodWidget extends StatefulWidget {
  /// Creates a [ChoosePeriodWidget].
  const ChoosePeriodWidget({
    required this.periodSelected,
    required this.defaultTextStyle,
    super.key,
    this.disabled = false,
  });

  /// Notifier holding the selected period.
  final ValueNotifier<PeriodModel> periodSelected;

  /// Whether selection is disabled.
  final bool disabled;

  /// Text style applied to segment labels.
  final TextStyle defaultTextStyle;

  @override
  State<ChoosePeriodWidget> createState() => _ChoosePeriodStateWidget();
}

class _ChoosePeriodStateWidget extends State<ChoosePeriodWidget> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<PeriodModel>(
      segments: List.generate(_periods.length, (index) {
        final period = _periods[index];

        return ButtonSegment<PeriodModel>(
          value: period,
          icon: Icon(
            period.iconData,
          ),
          label: Text(
            period.name,
            style: widget.defaultTextStyle,
          ),
        );
      }),
      selected: <PeriodModel>{
        widget.periodSelected.value,
      },
      onSelectionChanged: widget.disabled
          ? null
          : (value) {
              widget.periodSelected.value = value.first;
            },
    );
  }
}

/// Multi-select [SegmentedButton] over the available colors.
class ChooseColorsWidget extends StatefulWidget {
  /// Creates a [ChooseColorsWidget].
  const ChooseColorsWidget({
    required this.colorSelected,
    required this.defaultTextStyle,
    super.key,
    this.disabled = false,
  });

  /// Notifier holding the selected colors.
  final ValueNotifier<Set<Color>> colorSelected;

  /// Whether selection is disabled.
  final bool disabled;

  /// Text style applied to segment labels.
  final TextStyle defaultTextStyle;

  @override
  State<ChooseColorsWidget> createState() => _ChooseColorsWidgetState();
}

class _ChooseColorsWidgetState extends State<ChooseColorsWidget> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Color>(
      segments: List.generate(_colors.length, (index) {
        final color = _colors[index];

        return ButtonSegment<Color>(
          value: color,
          label: Text(
            '${color.name[0].toUpperCase()}${color.name.substring(1)}',
            style: widget.defaultTextStyle,
          ),
        );
      }),
      selected: widget.colorSelected.value,
      onSelectionChanged: widget.disabled
          ? null
          : (value) {
              widget.colorSelected.value = value;
            },
      multiSelectionEnabled: true,
    );
  }
}
