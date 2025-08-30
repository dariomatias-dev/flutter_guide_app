import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/custom_dialog/custom_dialog.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    this.title,
    this.description,
    this.actions = const <Widget>[],
    this.children = const <Widget>[],
  });

  final String? title;
  final String? description;
  final List<Widget> actions;
  final List<Widget> children;

  BorderRadius get borderRadius => BorderRadius.circular(32.0);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: Column(
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
            if (description != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
                child: Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        isLight ? Colors.grey.shade900 : Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(
                top: description != null ? 12.0 : 0.0,
                bottom: 14.0,
              ),
              child: Column(
                children: children,
              ),
            ),
            if (actions.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
                child: Row(
                  children: actions,
                ),
              ),
            ],
            const SizedBox(height: 26.0),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(child: Container()),
                  Expanded(
                    child: LineWidget(
                      color: isLight
                          ? Colors.grey.shade500.withAlpha(128)
                          : Colors.grey.shade600,
                      width: double.infinity,
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
