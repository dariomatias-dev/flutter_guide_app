import 'dart:async';

import 'package:flutter/material.dart';

/// A selectable dropdown option pairing a [value] with a display [name].
class MenuOptionModel<T> {
  /// Creates a [MenuOptionModel].
  const MenuOptionModel({
    required this.value,
    required this.name,
  });

  /// The option's underlying value.
  final T value;

  /// The option's display name.
  final String name;
}

/// Day names shown in the days-of-week dropdown.
const daysOfWeekNames = <String>[
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

/// Days of the week as dropdown options.
final List<MenuOptionModel<int>> daysOfWeek = List.generate(
  daysOfWeekNames.length,
  (index) {
    return MenuOptionModel(
      value: index,
      name: daysOfWeekNames[index],
    );
  },
);

/// Month names shown in the months-of-year dropdown.
const monthsOfYearNames = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

/// Months of the year as dropdown options.
final List<MenuOptionModel<int>> monthsOfYear = List.generate(
  monthsOfYearNames.length,
  (index) {
    return MenuOptionModel(
      value: index + 1,
      name: monthsOfYearNames[index],
    );
  },
);

/// City names shown in the world-cities dropdown.
const worldCitiesNames = <String>[
  'New York',
  'Los Angeles',
  'London',
  'Paris',
  'Tokyo',
  'Beijing',
  'Sydney',
  'Rio de Janeiro',
  'Dubai',
  'Moscow',
  'Toronto',
  'Hong Kong',
  'Berlin',
  'Singapore',
  'Mumbai',
  'Cape Town',
  'Rome',
  'Istanbul',
  'São Paulo',
  'Bangkok',
];

/// World cities as dropdown options.
final List<MenuOptionModel<String>> worldCities = List.generate(
  worldCitiesNames.length,
  (index) {
    final worldCitiesName = worldCitiesNames[index];

    return MenuOptionModel(
      value: worldCitiesName.toLowerCase().replaceAll(' ', '_'),
      name: worldCitiesNames[index],
    );
  },
);

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomDropdownSample(),
    ),
  );
}

/// Sample demonstrating `CustomDropdownSample`.
class CustomDropdownSample extends StatefulWidget {
  /// Creates a [CustomDropdownSample].
  const CustomDropdownSample({super.key});

  @override
  State<CustomDropdownSample> createState() => _CustomDropdownSampleState();
}

class _CustomDropdownSampleState extends State<CustomDropdownSample> {
  void _showSnackBar(
    String fieldName,
    String optionName,
  ) {
    final snackBar = SnackBar(
      content: Text(
        '$fieldName: $optionName',
      ),
      action: SnackBarAction(
        onPressed: () {},
        label: 'Ok',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              DropdownButtonWidget(
                title: 'Days of the Week',
                options: daysOfWeek,
                onChange: (value) {
                  _showSnackBar(
                    'Days of the Week',
                    value.name,
                  );
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonWidget(
                title: 'Months of the Year',
                options: monthsOfYear,
                onChange: (value) {
                  _showSnackBar(
                    'Months of the Year',
                    value.name,
                  );
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonWidget(
                title: 'Cities of the World',
                options: worldCities,
                onChange: (value) {
                  _showSnackBar(
                    'Cities of the World',
                    value.name,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sample demonstrating `DropdownButtonWidget`.
class DropdownButtonWidget extends StatefulWidget {
  /// Creates a [DropdownButtonWidget].
  const DropdownButtonWidget({
    required this.title,
    required this.options,
    required this.onChange,
    super.key,
  });

  /// Title shown when no option is selected.
  final String title;

  /// Options to display in the menu.
  final List<MenuOptionModel<Object?>> options;

  /// Called with the chosen option.
  /// The [onChange].
  final void Function(
    MenuOptionModel<Object?> value,
  ) onChange;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  final GlobalKey<State<StatefulWidget>> _dropdownButtonKey = GlobalKey();

  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  MenuOptionModel<Object?>? _selectedValue;

  BorderRadius get _defaultBorderRadius => BorderRadius.circular(20);

  BoxShadow get _boxShadow {
    return BoxShadow(
      color: Colors.black.withAlpha(77),
      blurRadius: 6,
      offset: const Offset(0, 1),
    );
  }

  void _showMenu() {
    final renderBox =
        _dropdownButtonKey.currentContext!.findRenderObject()! as RenderBox;
    final position = renderBox.globalToLocal(Offset.zero);

    final positionDy = position.dy * -1;

    final bottomSpace =
        MediaQuery.of(context).size.height - positionDy - renderBox.size.height;

    late final EdgeInsets padding;

    if (positionDy < (bottomSpace + (bottomSpace * 0.6))) {
      final topPadding = position.dy * -1 + renderBox.size.height + 6.0;

      padding = EdgeInsets.only(
        top: topPadding,
      );
    } else {
      final bottomPadding =
          MediaQuery.sizeOf(context).height - position.dy * -1 + 6.0;

      padding = EdgeInsets.only(
        bottom: bottomPadding,
      );
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return MenuWidget(
          selectedOption: _selectedValue,
          removeMenu: _removeMenu,
          boxShadow: _boxShadow,
          borderRadius: _defaultBorderRadius,
          padding: padding,
          options: widget.options,
          onChange: (value) {
            widget.onChange(value);

            _selectedValue = value;
          },
        );
      },
    );

    Overlay.of(context).insert(
      _overlayEntry!,
    );
  }

  void _removeMenu() {
    _isOpen = !_isOpen;
    _overlayEntry?.remove();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        _removeMenu();
      },
      child: GestureDetector(
        onTap: () {
          _isOpen = !_isOpen;
          _showMenu();

          setState(() {});
        },
        child: Container(
          key: _dropdownButtonKey,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.grey.shade900,
            borderRadius: _defaultBorderRadius,
            boxShadow: <BoxShadow>[
              _boxShadow,
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _selectedValue?.name ?? widget.title,
              ),
              Icon(
                _isOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sample demonstrating `MenuWidget`.
class MenuWidget extends StatefulWidget {
  /// Creates a [MenuWidget].
  const MenuWidget({
    required this.removeMenu,
    required this.boxShadow,
    required this.borderRadius,
    required this.padding,
    required this.options,
    required this.onChange,
    super.key,
    this.selectedOption,
  });

  /// Called to dismiss the menu.
  final VoidCallback removeMenu;

  /// Currently selected option, if any.
  final MenuOptionModel<Object?>? selectedOption;

  /// Shadow applied to the menu container.
  final BoxShadow boxShadow;

  /// Corner radius of the menu container.
  final BorderRadius borderRadius;

  /// Padding positioning the menu above or below the button.
  final EdgeInsets padding;

  /// Options to display.
  final List<MenuOptionModel<Object?>> options;

  /// Called with the chosen option.
  /// The [onChange].
  final void Function(
    MenuOptionModel<Object?> value,
  ) onChange;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  bool _isLight = true;
  Color? _defaultBackgroundColor;
  Color? _selectedBackgroundColor;
  double _opacity = 0;

  Future<void> _update() async {
    await Future<void>.delayed(
      const Duration(
        milliseconds: 10,
      ),
    );

    setState(() {
      _opacity = 1.0;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _isLight = Theme.of(context).brightness == Brightness.light;
      _defaultBackgroundColor = _isLight ? Colors.white : Colors.grey.shade900;
      _selectedBackgroundColor =
          _isLight ? Colors.grey.shade300.withAlpha(204) : Colors.black12;

      unawaited(_update());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isTopDirection = widget.padding.top != 0.0;
    final mediaQuery = MediaQuery.of(context);

    return GestureDetector(
      onTap: widget.removeMenu,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
            top: isTopDirection ? widget.padding.top : mediaQuery.padding.top,
            bottom: widget.padding.bottom,
            right: 12,
            left: 12,
          ),
          child: Column(
            mainAxisAlignment: isTopDirection
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: isTopDirection
                      ? mediaQuery.size.height - widget.padding.top - 40.0
                      : mediaQuery.size.height -
                          mediaQuery.padding.top -
                          widget.padding.bottom,
                ),
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(
                    milliseconds: 100,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: widget.borderRadius,
                      boxShadow: <BoxShadow>[
                        widget.boxShadow,
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: widget.borderRadius,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _defaultBackgroundColor,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children:
                                List.generate(widget.options.length, (index) {
                              final option = widget.options[index];

                              final selected =
                                  option.value == widget.selectedOption?.value;

                              return GestureDetector(
                                onTap: () {
                                  widget.removeMenu();
                                  widget.onChange(option);
                                },
                                child: Container(
                                  color: selected
                                      ? _selectedBackgroundColor
                                      : _defaultBackgroundColor,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  width: double.infinity,
                                  child: Text(
                                    option.name,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (isTopDirection) const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
