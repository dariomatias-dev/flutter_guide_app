import 'package:flutter/material.dart';

import 'package:flutter_guide/src/features/main/screens/settings/widgets/select_language/select_language_controller.dart';

import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

class SelectLanguageWidget extends StatefulWidget {
  const SelectLanguageWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<SelectLanguageWidget> createState() => _SelectLanguageWidgetState();
}

class _SelectLanguageWidgetState extends State<SelectLanguageWidget> {
  late final _controller = SelectLanguageController(
    context: context,
  );

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.primary;

    return ListTileItemWidget(
      onTap: () {
        _controller.showLanguageMenu(context, () {
          setState(() {});
        });
      },
      icon: Icons.language,
      title: widget.title,
      trailingWidgets: <Widget>[
        ValueListenableBuilder(
          valueListenable: _controller.selectedLanguageNotifier,
          builder: (context, language, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  language.name,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14.0,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: textColor,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
