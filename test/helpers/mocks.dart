import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_guide/src/features/catalog/data/datasources/favorites_local_datasource.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/components_repository.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/favorites_repository.dart';
import 'package:mocktail/mocktail.dart';

/// Mock of [SharedPreferencesService].
class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

/// Mock of [FavoritesLocalDatasource].
class MockFavoritesLocalDatasource extends Mock
    implements FavoritesLocalDatasource {}

/// Mock of [FavoritesRepository].
class MockFavoritesRepository extends Mock implements FavoritesRepository {}

/// Mock of [ComponentsRepository].
class MockComponentsRepository extends Mock implements ComponentsRepository {}
