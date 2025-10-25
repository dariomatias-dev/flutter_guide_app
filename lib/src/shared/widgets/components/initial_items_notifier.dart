import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/models/component_model.dart';

class InitialItemsNotifier extends ValueNotifier<List<ComponentModel>> {
  InitialItemsNotifier(super.value);

  void setComponents(
    List<ComponentModel> newComponents,
  ) {
    value = newComponents;

    notifyListeners();
  }
}
