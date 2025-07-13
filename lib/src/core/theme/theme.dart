import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/flutter_guide_colors.dart';

final ligthMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: FlutterGuideColors.darkNeutral50,
    secondary: FlutterGuideColors.blue100.withAlpha(128),
    tertiary: Colors.grey.shade800,
    surface: Colors.white,
  ),
);

final darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: FlutterGuideColors.ligthBlue200,
    secondary: FlutterGuideColors.darkNeutral,
    tertiary: Colors.grey,
    surface: FlutterGuideColors.darkNeutral50,
  ),
);
