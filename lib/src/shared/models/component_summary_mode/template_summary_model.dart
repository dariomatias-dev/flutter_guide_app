part of 'component_summary_mode.dart';

class TemplateSummaryModel extends ComponentSummaryModel {
  const TemplateSummaryModel({
    required super.name,
    required this.type,
    super.videoId,
    required super.sample,
    required super.fileName,
  });

  final ComponentType type;
}
