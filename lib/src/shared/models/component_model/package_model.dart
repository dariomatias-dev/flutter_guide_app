part of 'component_model.dart';

class PackageModel extends ComponentModel {
  const PackageModel({
    required super.name,
    required super.icon,
    super.videoId,
    required super.sample,
    super.type = ComponentType.package,
  });
}
