import 'package:flutter/material.dart';

/// A styled dialog with an optional title, description, body and actions.
class DialogWidget extends StatelessWidget {
  /// Creates a [DialogWidget].
  const DialogWidget({
    super.key,
    this.title,
    this.description,
    this.actions = const <Widget>[],
    this.children = const <Widget>[],
  });

  /// Optional title text.
  final String? title;

  /// Optional description text.
  final String? description;

  /// Action buttons shown at the bottom.
  final List<Widget> actions;

  /// Body widgets shown between the description and actions.
  final List<Widget> children;

  BorderRadius get _borderRadius => BorderRadius.circular(16);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: _borderRadius,
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            if (description != null)
              Padding(
                padding: EdgeInsets.only(
                  bottom:
                      (children.isNotEmpty || actions.isNotEmpty) ? 20.0 : 0.0,
                ),
                child: Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            if (children.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  top: (title != null || description != null) ? 20.0 : 0.0,
                  bottom: actions.isNotEmpty ? 24.0 : 0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            if (actions.isNotEmpty)
              Wrap(
                spacing: 12,
                children: actions,
              ),
          ],
        ),
      ),
    );
  }
}
