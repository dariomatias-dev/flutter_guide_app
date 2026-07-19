import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';

/// Popup menu entry that opens the documentation for a component.
class DocPopupMenuItemWidget extends PopupMenuEntry<Never> {
  /// Creates a [DocPopupMenuItemWidget].
  const DocPopupMenuItemWidget({
    required this.componentName,
    required this.type,
    super.key,
  });

  /// Name of the component to open documentation for.
  final String componentName;

  /// Type of the component, or `null` for packages.
  final ComponentType? type;

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(Object? value) => false;

  @override
  State<DocPopupMenuItemWidget> createState() => _DocPopupMenuItemWidgetState();

  static String _category(ComponentType type) {
    switch (type) {
      case ComponentType.widget:
        return 'widgets';
      case ComponentType.material:
      case ComponentType.function:
        return 'material';
      case ComponentType.cupertino:
      case ComponentType.package:
      case ComponentType.elements:
      case ComponentType.uis:
        return 'cupertino';
    }
  }
}

class _DocPopupMenuItemWidgetState extends State<DocPopupMenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuItem<void>(
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

        unawaited(
          openUrl(
            () => context,
            url,
          ),
        );
      },
      child: Text(AppLocalizations.of(context)!.doc),
    );
  }
}
