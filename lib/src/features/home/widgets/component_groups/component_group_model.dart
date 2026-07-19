import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

/// A named group of related components shown on the home screen.
class ComponentGroupModel {
  /// Creates a [ComponentGroupModel].
  const ComponentGroupModel({
    required this.icon,
    required this.title,
    required this.components,
  });

  /// Icon representing the group.
  final IconData icon;

  /// Resolves the localized group title.
  final String Function(AppLocalizations l10n) title;

  /// Names of the components in the group.
  final List<String> components;
}
