import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/features/catalog/data/datasources/components_local_datasource.dart';
import 'package:flutter_guide/src/features/catalog/data/repositories/components_repository_impl.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/components_repository.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/language_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final componentsRepositoryProvider = Provider<ComponentsRepository>((ref) {
  final language = ref.watch(languageViewModelProvider);

  return ComponentsRepositoryImpl(
    datasource: ComponentsLocalDatasource(),
    locale: LanguagesApp.locale(language),
  );
});
