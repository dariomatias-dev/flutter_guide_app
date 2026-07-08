import 'package:flutter/material.dart';

/// Total number of pages in the sample.
const numberOfPages = 10;

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginationSample(),
    ),
  );
}

/// Sample demonstrating `PaginationSample`.
class PaginationSample extends StatefulWidget {
  /// Creates a [PaginationSample].
  const PaginationSample({super.key});

  @override
  State<PaginationSample> createState() => _PaginationSampleState();
}

class _PaginationSampleState extends State<PaginationSample> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Page ${_selectedPageIndex + 1}',
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 40,
          child: Wrap(
            spacing: 12,
            alignment: WrapAlignment.center,
            children: <Widget>[
              StepNavigatorWidget(
                action: () {
                  setState(() {
                    _selectedPageIndex--;
                  });
                },
                disabled: _selectedPageIndex == 0,
                icon: Icons.keyboard_arrow_left_rounded,
              ),
              ...List.generate(5, (index) {
                var pageIndex = index;

                if (_selectedPageIndex > 2) {
                  if (_selectedPageIndex + 4 > numberOfPages) {
                    pageIndex += numberOfPages - 5;
                  } else {
                    pageIndex += _selectedPageIndex - 2;
                  }
                }

                final isPageIndex = _selectedPageIndex == pageIndex;

                return PageActionWidget(
                  action: () {
                    setState(() {
                      _selectedPageIndex = pageIndex;
                    });
                  },
                  fillColor: isPageIndex,
                  child: Center(
                    child: Text(
                      '${pageIndex + 1}',
                      style: TextStyle(
                        color: isPageIndex ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
              StepNavigatorWidget(
                action: () {
                  setState(() {
                    _selectedPageIndex++;
                  });
                },
                disabled: _selectedPageIndex == numberOfPages - 1,
                icon: Icons.keyboard_arrow_right_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sample demonstrating `StepNavigatorWidget`.
class StepNavigatorWidget extends StatelessWidget {
  /// Creates a [StepNavigatorWidget].
  const StepNavigatorWidget({
    required this.action,
    required this.disabled,
    required this.icon,
    super.key,
  });

  /// The [action].
  final VoidCallback action;

  /// The [disabled].
  final bool disabled;

  /// The [icon].
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return PageActionWidget(
      action: action,
      disabled: disabled,
      fillColor: false,
      child: Icon(
        icon,
        color: disabled ? Colors.grey.shade500 : Colors.black,
      ),
    );
  }
}

/// Sample demonstrating `PageActionWidget`.
class PageActionWidget extends StatelessWidget {
  /// Creates a [PageActionWidget].
  const PageActionWidget({
    required this.action,
    required this.fillColor,
    required this.child,
    super.key,
    this.disabled = false,
  });

  /// The [action].
  final VoidCallback action;

  /// The [disabled].
  final bool disabled;

  /// The [fillColor].
  final bool fillColor;

  /// The [child].
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : action,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: disabled
              ? Colors.grey.shade600
              : fillColor
                  ? Colors.black
                  : Colors.white,
          border: disabled ? null : Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
