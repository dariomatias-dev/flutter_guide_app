import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

part 'package_model.dart';
part 'widget_model.dart';
part 'functions_model.dart';

class ComponentModel {
  const ComponentModel({
    required this.name,
    required this.icon,
    this.videoId,
    required this.sample,
    required this.type,
  });

  final String name;
  final IconData icon;
  final String? videoId;
  final Widget sample;
  final ComponentType type;
}
