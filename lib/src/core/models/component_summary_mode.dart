import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

class ComponentSummaryModel {
  const ComponentSummaryModel({
    required this.name,
    this.videoId,
    required this.sample,
    this.fileName,
    required this.type,
  });

  final String name;
  final String? videoId;
  final Widget sample;
  final String? fileName;
  final ComponentType type;
}
