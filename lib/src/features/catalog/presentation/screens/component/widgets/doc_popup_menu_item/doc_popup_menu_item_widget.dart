import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';

class DocPopupMenuItemWidget extends PopupMenuEntry {
  const DocPopupMenuItemWidget({
    super.key,
    required this.componentName,
    required this.type,
  });

  final String componentName;
  final ComponentType? type;

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(value) => false;

  @override
  State<DocPopupMenuItemWidget> createState() => _DocPopupMenuItemWidgetState();

  static String _category(ComponentType type) {
    switch (type) {
      case ComponentType.widget:
        return 'widgets';
      case ComponentType.material:
      case ComponentType.function:
        return 'material';
      default:
        return 'cupertino';
    }
  }
}

class _DocPopupMenuItemWidgetState extends State<DocPopupMenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      onTap: () {
        String url;

        if (widget.type == null) {
          url = 'https://pub.dev/packages/${widget.componentName}';
        } else {
          final category = DocPopupMenuItemWidget._category(widget.type!);

          url = 'https://api.flutter.dev/flutter/$category/'
              '${widget.componentName}'
              '${widget.type != ComponentType.function ? '-class' : ''}.html';
        }

        openUrl(
          () => context,
          url,
        );
      },
      child: const Text('Doc'),
    );
  }
}
