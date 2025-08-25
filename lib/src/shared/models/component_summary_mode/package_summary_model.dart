part of 'component_summary_mode.dart';

class PackageSummaryModel extends ComponentSummaryModel {
  const PackageSummaryModel({
    required super.name,
    required this.type,
    super.videoId,
    required super.sample,
  });

  final ComponentType type;
}
