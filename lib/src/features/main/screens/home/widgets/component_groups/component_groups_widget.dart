import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/component_groups.dart';

import 'package:flutter_guide/src/features/main/screens/home/widgets/component_groups/component_group/component_group_widget.dart';

class ComponentGroupsWidget extends StatelessWidget {
  const ComponentGroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
          ),
          child: Text(
            AppLocalizations.of(context)!.components,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
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
