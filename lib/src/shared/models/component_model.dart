import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

class PackageModel extends ComponentModel {
  const PackageModel({
    required super.name,
    required super.icon,
    super.videoId,
    required super.sample,
    super.type = ComponentType.package,
  });
}

class ComponentModel {
  const ComponentModel({
    required this.name,
    this.icon,
    this.videoId,
    required this.sample,
    required this.type,
  });

  final String name;
  final IconData? icon;
  final String? videoId;
  final Widget sample;
  final ComponentType type;
}
