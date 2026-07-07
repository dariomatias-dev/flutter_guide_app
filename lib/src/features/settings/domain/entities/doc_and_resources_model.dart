import 'package:flutter/material.dart';

/// A documentation or resource link shown in settings.
class DocAndResourcesModel {
  /// Creates a [DocAndResourcesModel].
  const DocAndResourcesModel({
    required this.name,
    required this.icon,
    required this.url,
  });

  /// Display name of the resource.
  final String name;

  /// Icon representing the resource.
  final IconData icon;

  /// URL opened when the resource is tapped.
  final String url;
}
