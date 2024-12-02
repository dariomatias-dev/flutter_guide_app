import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/flutter_guide_colors.dart';

part 'action_button_widget.dart';
part 'dialog_widget.dart';
part 'line_widget.dart';
part 'custom_dialog_screen_widget.dart';

class CustomDialog {
  static DialogWidget dialog({
    bool? showLine,
    String? title,
    String? description,
    TextAlign descriptionTextAlign = TextAlign.center,
    double? spacingAction,
    required List<ActionButtonWidget> actions,
    bool? isActionFullWidth,
    required List<Widget> children,
  }) {
    return DialogWidget(
      showLine: showLine ?? true,
      title: title,
      description: description,
      descriptionTextAlign: descriptionTextAlign,
      spacingAction: spacingAction ?? 8.0,
      actions: actions,
      isActionFullWidth: isActionFullWidth ?? false,
      children: children,
    );
  }

  static ActionButtonWidget button({
    required String text,
    Color? backgroundColor,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ActionButtonWidget(
      text: text,
      textColor: textColor,
      backgroundColor: backgroundColor,
      onTap: onTap,
    );
  }
}
