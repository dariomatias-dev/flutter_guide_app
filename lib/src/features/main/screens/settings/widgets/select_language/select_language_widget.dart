import 'package:flutter/material.dart';

import 'package:flutter_guide/src/features/main/screens/settings/widgets/select_language/select_language_controller.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

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
  late SelectLanguageController _controller;

  @override
  void didChangeDependencies() {
    _controller = SelectLanguageController(
      context: context,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

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
            return ValueListenableBuilder(
              valueListenable: themeController,
              builder: (context, value, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      language.name,
                      style: TextStyle(
                        color: themeController.theme.colorScheme.primary,
                        fontSize: 14.0,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: themeController.theme.colorScheme.primary,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
