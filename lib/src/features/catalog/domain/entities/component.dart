import 'package:flutter/widgets.dart' show IconData;

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

/// A catalog component in the domain layer.
class Component {
  /// Creates a [Component].
  const Component({
    required this.name,
    required this.type,
    this.icon,
    this.videoId,
    this.fileName,
  });

  /// Display name of the component.
  final String name;

  /// Category the component belongs to.
  final ComponentType type;

  /// Optional icon representing the component.
  final IconData? icon;

  /// Optional YouTube video id explaining the component.
  final String? videoId;

  /// Optional source file name backing the component.
  final String? fileName;
}
