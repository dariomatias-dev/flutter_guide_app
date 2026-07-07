import 'package:flutter/material.dart';

/// A named group of related components shown on the home screen.
class ComponentGroupModel {
  /// Creates a [ComponentGroupModel].
  const ComponentGroupModel({
    required this.icon,
    required this.title,
    required this.components,
  });

  /// Icon representing the group.
  final IconData icon;

  /// Group title.
  final String title;

  /// Names of the components in the group.
  final List<String> components;
}
