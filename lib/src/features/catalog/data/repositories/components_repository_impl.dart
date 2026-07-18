import 'dart:ui';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/datasources/components_local_datasource.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/components_repository.dart';

/// Default [ComponentsRepository] backed by a local datasource.
class ComponentsRepositoryImpl implements ComponentsRepository {
  /// Creates a [ComponentsRepositoryImpl].
  ComponentsRepositoryImpl({
    required ComponentsLocalDatasource datasource,
    required Locale locale,
  })  : _datasource = datasource,
        _locale = locale;

  final ComponentsLocalDatasource _datasource;
  final Locale _locale;
  final _cache = <ComponentType, List<Component>>{};

  @override
  List<Component> getComponentsByType(ComponentType type) {
    return _cache.putIfAbsent(
      type,
      () => _datasource.getByType(type, locale: _locale),
    );
  }

  @override
  Component getComponentByName({
    required ComponentType type,
    required String name,
  }) {
    return _datasource.getByName(
      type: type,
      name: name,
      locale: _locale,
    );
  }
}
