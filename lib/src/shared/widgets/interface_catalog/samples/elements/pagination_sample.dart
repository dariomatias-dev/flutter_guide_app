import 'package:flutter/material.dart';

const numberOfPages = 10;

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginationSample(),
    ),
  );
}

class PaginationSample extends StatefulWidget {
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
      bottomNavigationBar: SizedBox(
        height: 40.0,
        child: Wrap(
          spacing: 12.0,
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
              int pageIndex = index;

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
    );
  }
}

class StepNavigatorWidget extends StatelessWidget {
  const StepNavigatorWidget({
    super.key,
    required this.action,
    required this.disabled,
    required this.icon,
  });

  final VoidCallback action;
  final bool disabled;
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

class PageActionWidget extends StatelessWidget {
  const PageActionWidget({
    super.key,
    required this.action,
    this.disabled = false,
    required this.fillColor,
    required this.child,
  });

  final VoidCallback action;
  final bool disabled;
  final bool fillColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : action,
      child: Container(
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
          color: disabled
              ? Colors.grey.shade600
              : fillColor
                  ? Colors.black
                  : Colors.white,
          border: disabled
              ? null
              : Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
