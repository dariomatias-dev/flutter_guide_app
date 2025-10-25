import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({
    super.key,
    required this.color,
    required this.width,
  });

  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 4.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
