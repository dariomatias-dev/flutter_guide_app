import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

const _mshCheckboxStyles = <MSHCheckboxStyle>[
  MSHCheckboxStyle.stroke,
  MSHCheckboxStyle.fillFade,
  MSHCheckboxStyle.fillScaleCheck,
  MSHCheckboxStyle.fillScaleColor,
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MshCheckboxSample(),
    ),
  );
}

class MshCheckboxSample extends StatelessWidget {
  const MshCheckboxSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 12.0,
          children: List.generate(_mshCheckboxStyles.length, (index) {
            return MshCheckboxItemSample(
              style: _mshCheckboxStyles[index],
            );
          }),
        ),
      ),
    );
  }
}

class MshCheckboxItemSample extends StatefulWidget {
  const MshCheckboxItemSample({
    super.key,
    required this.style,
  });

  final MSHCheckboxStyle style;

  @override
  State<MshCheckboxItemSample> createState() => _MshCheckboxItemSampleState();
}

class _MshCheckboxItemSampleState extends State<MshCheckboxItemSample> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return MSHCheckbox(
      value: _isChecked,
      size: 32.0,
      style: widget.style,
      colorConfig: MSHColorConfig(
        checkColor: widget.style == MSHCheckboxStyle.stroke
            ? (value) {
                return Colors.blue;
              }
            : null,
        tintColor: (value) {
          return Colors.blue;
        },
        fillColor: (value) {
          return Colors.blue;
        },
      ),
      onChanged: (selected) {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
    );
  }
}
