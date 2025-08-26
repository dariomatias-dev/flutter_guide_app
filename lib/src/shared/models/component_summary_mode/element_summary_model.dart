part of 'component_summary_mode.dart';

class ElementSummaryModel extends ComponentSummaryModel {
  const ElementSummaryModel({
    required super.name,
    required this.type,
    super.videoId,
    required super.sample,
    required super.fileName,
  });

  final ComponentType type;
}
