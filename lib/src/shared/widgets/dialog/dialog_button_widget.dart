import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/flutter_guide_colors.dart';

class DialogButtonWidget extends StatelessWidget {
  const DialogButtonWidget({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor,
    this.backgroundColor,
  });

  final VoidCallback onTap;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48.0,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? FlutterGuideColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
