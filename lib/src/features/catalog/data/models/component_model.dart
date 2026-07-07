import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

/// A [ComponentModel] fixed to [ComponentType.package].
class PackageModel extends ComponentModel {
  /// Creates a [PackageModel].
  const PackageModel({
    required super.name,
    required super.icon,
    required super.sample,
    super.videoId,
    super.type = ComponentType.package,
  });
}

/// Data model describing a catalog component and its runnable sample.
class ComponentModel {
  /// Creates a [ComponentModel].
  const ComponentModel({
    required this.name,
    required this.sample,
    required this.type,
    this.icon,
    this.videoId,
  });

  /// Display name of the component.
  final String name;

  /// Optional icon representing the component.
  final IconData? icon;

  /// Optional YouTube video id explaining the component.
  final String? videoId;

  /// The runnable sample widget.
  final Widget sample;

  /// Category the component belongs to.
  final ComponentType type;
}
