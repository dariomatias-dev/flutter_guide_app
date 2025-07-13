import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/links/app_links.dart';

import 'package:flutter_guide/src/shared/models/doc_and_resources_model.dart';

List<DocAndResourcesModel> getDocsAndResources(BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;

  return <DocAndResourcesModel>[
    DocAndResourcesModel(
      name: appLocalizations.flutterDocs,
      icon: Icons.library_books,
      url: AppLinks.flutterDocs,
    ),
    DocAndResourcesModel(
      name: appLocalizations.dartDocs,
      icon: Icons.code,
      url: AppLinks.dartDocs,
    ),
    const DocAndResourcesModel(
      name: 'Dart Pad',
      icon: Icons.edit,
      url: AppLinks.dartPad,
    ),
    DocAndResourcesModel(
      name: 'pub.dev - ${appLocalizations.packages}',
      icon: Icons.shop,
      url: AppLinks.pubDev,
    ),
    DocAndResourcesModel(
      name: appLocalizations.samples,
      icon: Icons.collections,
      url: AppLinks.flutterSamples,
    ),
  ];
}
