import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/component_sample/widgets/code_tab/code_tab_controller.dart';

class CodeTab extends StatefulWidget {
  const CodeTab({
    super.key,
    required this.fontSizeNotifier,
  });

  final ValueNotifier<double> fontSizeNotifier;

  @override
  State<CodeTab> createState() => _CodeTabState();
}

class _CodeTabState extends State<CodeTab> {
  late CodeTabController _controller;

  @override
  void didChangeDependencies() {
    _controller = CodeTabController(
      context: context,
      setStateCallback: () {
        setState(() {});
      },
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _controller.themeController.theme.copyWith(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
        ),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 6.0,
            ),
            child: ValueListenableBuilder(
              valueListenable: widget.fontSizeNotifier,
              builder: (context, value, child) {
                return SelectableText.rich(
                  _controller.code,
                  style: TextStyle(
                    fontSize: value,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
