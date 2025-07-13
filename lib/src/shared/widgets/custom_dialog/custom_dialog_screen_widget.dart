part of 'custom_dialog.dart';

class CustomDialogScreenWidget extends StatelessWidget {
  const CustomDialogScreenWidget({
    super.key,
    required this.removeDocs,
    required this.child,
  });

  final VoidCallback removeDocs;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: removeDocs,
          child: Container(
            color: Colors.black.withAlpha(153),
            constraints: const BoxConstraints.expand(),
            child: Container(
              color: Colors.blue.shade100.withAlpha(
                Theme.of(context).brightness == Brightness.light ? 77 : 0,
              ),
              constraints: const BoxConstraints.expand(),
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const IgnorePointer(
                child: SizedBox(width: 32.0),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: child,
                  ),
                ),
              ),
              const IgnorePointer(
                child: SizedBox(width: 32.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
