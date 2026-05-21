import 'package:flutter/material.dart';

class ComponentSampleArgs {
  const ComponentSampleArgs({
    required this.title,
    required this.filePath,
    required this.componentName,
    required this.sample,
    this.popupMenuItems,
  });

  final String title;
  final String filePath;
  final String componentName;
  final Widget sample;
  final List<PopupMenuEntry>? popupMenuItems;
}
