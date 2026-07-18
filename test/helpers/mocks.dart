import 'package:flutter_guide/src/core/helpers/deep_link_handler.dart';
import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_guide/src/features/catalog/data/datasources/components_local_datasource.dart';
import 'package:flutter_guide/src/features/catalog/data/datasources/favorites_local_datasource.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/components_repository.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/favorites_repository.dart';
import 'package:flutter_guide/src/features/code_theme_selector/domain/repositories/code_theme_repository.dart';
import 'package:flutter_guide/src/features/settings/domain/repositories/language_repository.dart';
import 'package:logger/logger.dart';
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

/// Mock of [ComponentsLocalDatasource].
class MockComponentsLocalDatasource extends Mock
    implements ComponentsLocalDatasource {}

/// Mock of [LanguageRepository].
class MockLanguageRepository extends Mock implements LanguageRepository {}

/// Mock of [CodeThemeRepository].
class MockCodeThemeRepository extends Mock implements CodeThemeRepository {}

/// Mock of [DeepLinkHandler].
class MockDeepLinkHandler extends Mock implements DeepLinkHandler {}

/// Mock of [Logger].
class MockLogger extends Mock implements Logger {}
