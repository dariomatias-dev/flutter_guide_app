import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/view_models/favorites_view_model.dart';

final favoritesViewModelProvider = NotifierProvider<
    FavoritesViewModel, Map<ComponentType, Set<String>>>(
  FavoritesViewModel.new,
);
