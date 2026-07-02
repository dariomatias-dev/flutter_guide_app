import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/router/app_routes.dart';

class SelectFavoriteScreenDialogController {
  SelectFavoriteScreenDialogController({
    required BuildContext context,
  }) : _context = context;

  final BuildContext _context;

  void navigateTo(ComponentType componentType) {
    AppRoutes.pushSavedComponents(_context, type: componentType);
  }
}
