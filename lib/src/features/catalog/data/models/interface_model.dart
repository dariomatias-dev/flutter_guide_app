import 'package:flutter_guide/src/features/catalog/data/models/component_model.dart';

class InterfaceModel extends ComponentModel {
  const InterfaceModel({
    required super.name,
    required super.type,
    required this.fileName,
    super.icon,
    required super.sample,
  });

  final String fileName;
}
