import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/features/catalog/data/datasources/favorites_local_datasource.dart';
import 'package:flutter_guide/src/features/catalog/data/repositories/favorites_repository_impl.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/favorites_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the [FavoritesRepository].
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl(
    FavoritesLocalDatasource(ref.read(sharedPreferencesServiceProvider)),
  );
});
