part of 'component_summary_mode.dart';

class UiSummaryModel extends ComponentSummaryModel {
  const UiSummaryModel({
    required super.name,
    required this.type,
    super.videoId,
    required super.sample,
    required super.fileName,
  });

  final ComponentType type;
}
