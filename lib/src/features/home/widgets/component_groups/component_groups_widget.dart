import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/features/home/widgets/component_groups/component_group/component_group_widget.dart';
import 'package:flutter_guide/src/features/home/widgets/component_groups/component_groups.dart';

/// Section listing all component groups on the home screen.
class ComponentGroupsWidget extends StatelessWidget {
  /// Creates a [ComponentGroupsWidget].
  const ComponentGroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
          ),
          child: Text(
            AppLocalizations.of(context)!.components,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Column(
          children: List.generate(componentGroups.length, (index) {
            return ComponentGroupWidget(
              componentGroup: componentGroups[index],
            );
          }),
        ),
      ],
    );
  }
}
