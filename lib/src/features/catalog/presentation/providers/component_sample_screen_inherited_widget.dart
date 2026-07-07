import 'package:flutter/material.dart';

/// Exposes the current sample's file name and component name to descendants.
class ComponentSampleScreenInheritedWidget extends InheritedWidget {
  /// Creates a [ComponentSampleScreenInheritedWidget].
  const ComponentSampleScreenInheritedWidget({
    required this.fileName,
    required this.componentName,
    required super.child,
    super.key,
  });

  /// Source file name of the current sample.
  final String fileName;

  /// Name of the current component.
  final String componentName;

  /// Returns the nearest instance from [context], if any.
  static ComponentSampleScreenInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        ComponentSampleScreenInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ComponentSampleScreenInheritedWidget oldWidget) {
    return true;
  }
}
