part of 'custom_dialog.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.showLine,
    this.title,
    this.description,
    required this.descriptionTextAlign,
    required this.spacingAction,
    required this.actions,
    required this.isActionFullWidth,
    required this.children,
  });

  final bool showLine;
  final String? title;
  final String? description;
  final TextAlign descriptionTextAlign;
  final double spacingAction;
  final List<ActionButtonWidget> actions;
  final bool isActionFullWidth;
  final List<Widget> children;

  BorderRadius get borderRadius => BorderRadius.circular(32.0);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (showLine)
          Padding(
            padding: const EdgeInsets.only(
              top: 6.0,
              bottom: 16.0,
            ),
            child: Center(
              child: LineWidget(
                color: isLight
                    ? Colors.grey.shade400.withOpacity(0.6)
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
              textAlign: descriptionTextAlign,
              style: TextStyle(
                color: isLight ? Colors.grey.shade900 : Colors.grey.shade400,
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
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Row(
            children: actions.length == 1
                ? <Widget>[
                    if (!isActionFullWidth)
                      Expanded(
                        child: Container(),
                      ),
                    actions[0]
                  ]
                : <Widget>[
                    actions[0],
                    SizedBox(
                      width: spacingAction,
                    ),
                    actions[1]
                  ],
          ),
        ),
        const SizedBox(height: 26.0),
        if (showLine)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  child: LineWidget(
                    color: isLight
                        ? Colors.grey.shade500.withOpacity(0.5)
                        : Colors.grey.shade600,
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
