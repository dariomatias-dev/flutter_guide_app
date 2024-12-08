import 'package:flutter/material.dart';

class MenuOptionModel<T> {
  const MenuOptionModel({
    required this.value,
    required this.name,
  });

  final T value;
  final String name;
}

const daysOfWeekNames = <String>[
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

final daysOfWeek = List.generate(daysOfWeekNames.length, (index) {
  return MenuOptionModel(
    value: index,
    name: daysOfWeekNames[index],
  );
});

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
  'December'
];

final monthsOfYear = List.generate(monthsOfYearNames.length, (index) {
  return MenuOptionModel(
    value: index + 1,
    name: monthsOfYearNames[index],
  );
});

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

final worldCities = List.generate(worldCitiesNames.length, (index) {
  final worldCitiesName = worldCitiesNames[index];

  return MenuOptionModel(
    value: worldCitiesName.toLowerCase().replaceAll(' ', '_'),
    name: worldCitiesNames[index],
  );
});

class CustomDropdownSample extends StatefulWidget {
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
          horizontal: 12.0,
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
              const SizedBox(height: 16.0),
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
              const SizedBox(height: 16.0),
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

class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget({
    super.key,
    required this.title,
    required this.options,
    required this.onChange,
  });

  final String title;
  final List<MenuOptionModel> options;
  final void Function(
    MenuOptionModel value,
  ) onChange;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  final _dropdownButtonKey = GlobalKey();

  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  MenuOptionModel? _selectedValue;

  BorderRadius get _defaultBorderRadius => BorderRadius.circular(20.0);

  BoxShadow get _boxShadow {
    return BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 6.0,
      spreadRadius: 0.0,
      offset: const Offset(0, 1),
    );
  }

  void _showMenu() {
    final renderBox =
        _dropdownButtonKey.currentContext!.findRenderObject() as RenderBox;
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
      onPopInvoked: (didPop) {
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
            vertical: 10.0,
            horizontal: 12.0,
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

class MenuWidget extends StatefulWidget {
  const MenuWidget({
    super.key,
    required this.removeMenu,
    this.selectedOption,
    required this.boxShadow,
    required this.borderRadius,
    required this.padding,
    required this.options,
    required this.onChange,
  });

  final VoidCallback removeMenu;
  final MenuOptionModel? selectedOption;
  final BoxShadow boxShadow;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final List<MenuOptionModel> options;
  final void Function(
    MenuOptionModel value,
  ) onChange;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  bool _isLight = true;
  Color? _defaultBackgroundColor;
  Color? _selectedBackgroundColor;
  double _opacity = 0.0;

  Future<void> _update() async {
    await Future.delayed(
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
          _isLight ? Colors.grey.shade300.withOpacity(0.8) : Colors.black12;

      _update();
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
            right: 12.0,
            left: 12.0,
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
                          vertical: 6.0,
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
                                    horizontal: 12.0,
                                    vertical: 8.0,
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
