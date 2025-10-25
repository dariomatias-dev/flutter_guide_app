import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/extensions/list_extension.dart';

import 'package:flutter_guide/src/shared/widgets/dialogs/line_widget.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    this.title,
    required this.content,
    required this.actions,
  });

  final String? title;
  final Widget content;
  final List<Widget> actions;

  BorderRadius get borderRadius => BorderRadius.circular(32.0);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 6.0,
            bottom: 16.0,
          ),
          child: Center(
            child: LineWidget(
              color: isLight
                  ? Colors.grey.shade400.withAlpha(153)
                  : Colors.grey.shade500,
              width: 32.0,
            ),
          ),
        ),
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
            ),
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        content,
        const SizedBox(height: 24.0),
        if (actions.isNotEmpty)
          Row(
            spacing: 20.0,
            children: actions.builder(
              (action, index) => Expanded(child: action),
            ),
          ),
        const SizedBox(height: 32.0),
        Row(
          children: <Widget>[
            const Expanded(
              child: SizedBox(),
            ),
            Expanded(
              child: LineWidget(
                color: isLight
                    ? Colors.grey.shade500.withAlpha(128)
                    : Colors.grey.shade600,
                width: double.infinity,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ],
    );
  }
}
