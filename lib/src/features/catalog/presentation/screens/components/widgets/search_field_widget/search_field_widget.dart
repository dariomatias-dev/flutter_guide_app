import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

/// Search field shown above component lists, with a clear button.
class SearchFieldWidget extends StatefulWidget {
  /// Creates a [SearchFieldWidget].
  const SearchFieldWidget({
    required this.componentType,
    required this.onChange,
    required this.searchClear,
    super.key,
  });

  /// Category being searched, used for the hint text.
  final ComponentType componentType;

  /// Called with the query whenever it changes.
  final void Function(
    String value,
  ) onChange;

  /// Called when the search is cleared.
  final VoidCallback searchClear;

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final _searchFieldController = TextEditingController();

  void _searchFieldClear() {
    widget.searchClear();
    _searchFieldController.clear();
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade500
            : Colors.grey.shade400,
        width: 0.5,
      ),
    );
  }

  @override
  void dispose() {
    _searchFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    late final String hintText;
    switch (widget.componentType) {
      case ComponentType.widget:
        hintText = 'Widget';
      case ComponentType.function:
        hintText = appLocalizations.function;
      case ComponentType.material:
      case ComponentType.cupertino:
      case ComponentType.package:
      case ComponentType.elements:
      case ComponentType.uis:
        hintText = appLocalizations.package;
    }

    final iconColor = Theme.of(context).colorScheme.tertiary;

    return Container(
      width: double.infinity,
      height: 44,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: TextFormField(
        controller: _searchFieldController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: iconColor,
            size: 20,
          ),
          suffixIcon: GestureDetector(
            onTap: _searchFieldClear,
            child: Icon(
              Icons.close,
              color: iconColor,
              size: 20,
            ),
          ),
          hintText: '$hintText...',
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border.copyWith(
            borderSide: BorderSide(
              color: _border.borderSide.color,
            ),
          ),
        ),
        onChanged: widget.onChange,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
