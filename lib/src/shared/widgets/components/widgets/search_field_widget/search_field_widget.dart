import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/shared/widgets/components/widgets/search_field_widget/search_field_controller.dart';

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({
    super.key,
    required this.componentType,
    required this.onChange,
    required this.searchClear,
  });

  final ComponentType componentType;
  final void Function(
    String value,
  ) onChange;
  final VoidCallback searchClear;

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  late final _controller = SearchFieldController(
    searchClear: widget.searchClear,
  );

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    late final String hintText;
    switch (widget.componentType) {
      case ComponentType.widget:
        hintText = 'Widget';
        break;
      case ComponentType.function:
        hintText = appLocalizations.function;
        break;
      default:
        hintText = appLocalizations.package;
    }

    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return Container(
      width: double.infinity,
      height: 44.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: ValueListenableBuilder(
        valueListenable: themeController,
        builder: (context, value, child) {
          return TextFormField(
            controller: _controller.searchFieldController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: themeController.theme.colorScheme.tertiary,
                size: 20.0,
              ),
              suffixIcon: GestureDetector(
                onTap: _controller.searchFieldClear,
                child: Icon(
                  Icons.close,
                  color: themeController.theme.colorScheme.tertiary,
                  size: 20.0,
                ),
              ),
              hintText: '$hintText...',
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: themeController.isLight
                      ? Colors.grey.shade400
                      : Colors.grey.shade500,
                ),
              ),
            ),
            onChanged: widget.onChange,
          );
        },
      ),
    );
  }
}
