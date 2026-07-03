import 'dart:ui';

import 'package:flutter/widgets.dart' show Widget;
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/datasources/components_local_datasource.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component_entity.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/components_repository.dart';

class ComponentsRepositoryImpl implements ComponentsRepository {
  ComponentsRepositoryImpl({
    required ComponentsLocalDatasource datasource,
    required Locale locale,
  })  : _datasource = datasource,
        _locale = locale;

  final ComponentsLocalDatasource _datasource;
  final Locale _locale;

  @override
  List<ComponentEntity> getComponentsByType(ComponentType type) {
    return _datasource.getByType(type, locale: _locale);
  }

  @override
  ComponentEntity getComponentByName({
    required ComponentType type,
    required String name,
  }) {
    return _datasource.getByName(
      type: type,
      name: name,
      locale: _locale,
    );
  }

  @override
  Widget getSampleWidget({
    required ComponentType type,
    required String name,
  }) {
    return _datasource.getSampleWidget(type: type, name: name);
  }
}
