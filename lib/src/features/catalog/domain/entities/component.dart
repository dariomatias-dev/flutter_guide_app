import 'package:flutter/widgets.dart' show IconData;

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

class Component {
  const Component({
    required this.name,
    required this.type,
    this.icon,
    this.videoId,
    this.fileName,
  });

  final String name;
  final ComponentType type;
  final IconData? icon;
  final String? videoId;
  final String? fileName;
}
