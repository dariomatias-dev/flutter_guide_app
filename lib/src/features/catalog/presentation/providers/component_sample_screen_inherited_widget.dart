import 'package:flutter/material.dart';

class ComponentSampleScreenInheritedWidget extends InheritedWidget {
  const ComponentSampleScreenInheritedWidget({
    super.key,
    required this.fileName,
    required this.componentName,
    required super.child,
  });

  final String fileName;
  final String componentName;

  static ComponentSampleScreenInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        ComponentSampleScreenInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ComponentSampleScreenInheritedWidget oldWidget) {
    return true;
  }
}
