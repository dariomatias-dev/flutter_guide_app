import 'package:flutter/material.dart';

/// Route arguments for the component sample viewer screen.
class ComponentSampleArgs {
  /// Creates a [ComponentSampleArgs].
  const ComponentSampleArgs({
    required this.title,
    required this.filePath,
    required this.componentName,
    required this.sample,
    this.popupMenuItems,
  });

  /// Title shown in the app bar.
  final String title;

  /// Path to the sample's source file.
  final String filePath;

  /// Name of the component being shown.
  final String componentName;

  /// The runnable sample widget.
  final Widget sample;

  /// Optional extra popup menu entries for the app bar.
  final List<PopupMenuEntry<dynamic>>? popupMenuItems;
}
