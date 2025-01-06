import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/component/widgets/doc_popup_menu_item/doc_popup_menu_item_controller.dart';

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
  State<DocPopupMenuItemWidget> createState() => _PopupMenuItemDocWidgetState();
}

class _PopupMenuItemDocWidgetState extends State<DocPopupMenuItemWidget> {
  final _controller = DocPopupMenuItemController();

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      onTap: () {
        String url = '';

        if (widget.type == null) {
          url = 'https://pub.dev/packages/${widget.componentName}';
        } else {
          final type = _controller.getCategory(
            widget.type!,
          );

          url =
              'https://api.flutter.dev/flutter/$type/${widget.componentName}';

          url +=
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
