import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Type scale shared by both themes.
///
/// Named after the [TextTheme] roles they replace at each call site, sized
/// to the values already in use so composing this theme changes nothing a
/// screenshot would catch. Color stays a per-widget concern, applied with
/// `copyWith` where a style is read from here.
const _textTheme = TextTheme(
  titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontSize: 14),
  bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
  labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
);

/// The app's light [ThemeData].
final lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: _textTheme,
  colorScheme: ColorScheme.light(
    primary: FlutterGuideColors.darkNeutral50,
    secondary: FlutterGuideColors.blue100.withAlpha(128),
    tertiary: Colors.grey.shade800,
  ),
);

/// The app's dark [ThemeData].
final darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: _textTheme,
  colorScheme: const ColorScheme.dark(
    primary: FlutterGuideColors.lightBlue200,
    secondary: FlutterGuideColors.darkNeutral,
    tertiary: Colors.grey,
    surface: FlutterGuideColors.darkNeutral50,
  ),
);
