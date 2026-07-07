import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

/// Summary metadata describing a single catalog sample.
class ComponentSummaryModel {
  /// Creates a summary for a catalog sample.
  const ComponentSummaryModel({
    required this.name,
    required this.sample,
    required this.type,
    this.videoId,
    this.fileName,
  });

  /// Display name of the component.
  final String name;

  /// Optional YouTube video id explaining the component.
  final String? videoId;

  /// The runnable sample widget.
  final Widget sample;

  /// Optional source file name backing the sample.
  final String? fileName;

  /// The category this component belongs to.
  final ComponentType type;
}
