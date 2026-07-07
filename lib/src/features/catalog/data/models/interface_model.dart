import 'package:flutter_guide/src/features/catalog/data/models/component_model.dart';

/// A [ComponentModel] for interface samples, backed by a source file.
class InterfaceModel extends ComponentModel {
  /// Creates an [InterfaceModel].
  const InterfaceModel({
    required super.name,
    required super.type,
    required this.fileName,
    required super.sample,
    super.icon,
  });

  /// Source file name backing the interface sample.
  final String fileName;
}
