import 'package:flutter/material.dart';

class _AlignmentModel {
  const _AlignmentModel({
    required this.name,
    required this.alignment,
  });

  final String name;
  final Alignment alignment;
}

const _alignments = <_AlignmentModel>[
  _AlignmentModel(
    name: 'Bottom Center',
    alignment: Alignment.bottomCenter,
  ),
  _AlignmentModel(
    name: 'Bottom Left',
    alignment: Alignment.bottomLeft,
  ),
  _AlignmentModel(
    name: 'Bottom Right',
    alignment: Alignment.bottomRight,
  ),
  _AlignmentModel(
    name: 'Center',
    alignment: Alignment.center,
  ),
  _AlignmentModel(
    name: 'Center Left',
    alignment: Alignment.centerLeft,
  ),
  _AlignmentModel(
    name: 'Center Right',
    alignment: Alignment.centerRight,
  ),
  _AlignmentModel(
    name: 'Top Center',
    alignment: Alignment.topCenter,
  ),
  _AlignmentModel(
    name: 'Top Left',
    alignment: Alignment.topLeft,
  ),
  _AlignmentModel(
    name: 'Top Right',
    alignment: Alignment.topRight,
  ),
];

class AlignSample extends StatefulWidget {
  const AlignSample({super.key});

  @override
  State<AlignSample> createState() => _AlignSampleState();
}

class _AlignSampleState extends State<AlignSample> {
  _AlignmentModel _alignment = const _AlignmentModel(
    name: 'Center',
    alignment: Alignment.center,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: _alignment.alignment,
              child: const Text('Content'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _alignment,
                items: List.generate(_alignments.length, (index) {
                  final alignment = _alignments[index];

                  return DropdownMenuItem(
                    value: alignment,
                    child: Text(
                      alignment.name,
                    ),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _alignment = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
