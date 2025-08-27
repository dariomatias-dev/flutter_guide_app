import 'package:flutter/material.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

import 'package:flutter_guide/src/core/enums/theme_type_enum.dart';

import 'package:flutter_guide/src/features/code_theme_selector/widgets/theme_card_widget.dart';

class ThemeListWidget extends StatelessWidget {
  const ThemeListWidget({
    super.key,
    required this.themes,
    required this.themeType,
    required this.selectedSchema,
    required this.onThemeSelected,
    required this.previewCode,
  });

  final List<(String, SyntaxColorSchema)> themes;
  final ThemeType themeType;
  final SyntaxColorSchema selectedSchema;
  final void Function(
    String name,
    SyntaxColorSchema schema,
  ) onThemeSelected;
  final String previewCode;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 20.0,
        right: 16.0,
        bottom: 36.0,
        left: 16.0,
      ),
      itemCount: themes.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12.0);
      },
      itemBuilder: (context, index) {
        final (name, schema) = themes[index];

        return ThemeCardWidget(
          themeName: name,
          themeSchema: schema,
          themeType: themeType,
          isSelected: selectedSchema == schema,
          previewCode: previewCode,
          onTap: () {
            onThemeSelected(name, schema);
          },
        );
      },
    );
  }
}
