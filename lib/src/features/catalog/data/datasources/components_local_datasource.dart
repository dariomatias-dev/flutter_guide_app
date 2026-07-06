import 'dart:ui';

import 'package:flutter/widgets.dart' show Widget;
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/functions.dart'
    as functions_source;
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/packages.dart'
    as packages_source;
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/widgets.dart'
    as widgets_source;
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';
import 'package:flutter_guide/src/shared/models/component_model.dart';

class ComponentsLocalDatasource {
  List<Component> getByType(
    ComponentType type, {
    required Locale locale,
  }) {
    switch (type) {
      case ComponentType.function:
        return functions_source.functions.map(_fromComponentModel).toList();
      case ComponentType.package:
        return packages_source.packages.map(_fromComponentModel).toList();
      case ComponentType.elements:
        return _getElements(locale);
      case ComponentType.uis:
        return _getUis(locale);
      case ComponentType.widget:
      case ComponentType.material:
      case ComponentType.cupertino:
        return widgets_source.widgets.map(_fromComponentModel).toList();
    }
  }

  Component getByName({
    required ComponentType type,
    required String name,
    required Locale locale,
  }) {
    return getByType(type, locale: locale).firstWhere(
      (component) => component.name == name,
    );
  }

  Widget getSampleWidget({
    required ComponentType type,
    required String name,
  }) {
    switch (type) {
      case ComponentType.function:
        return functions_source.functions
            .firstWhere((component) => component.name == name)
            .sample;
      case ComponentType.package:
        return packages_source.packages
            .firstWhere((component) => component.name == name)
            .sample;
      case ComponentType.widget:
      case ComponentType.material:
      case ComponentType.cupertino:
        return widgets_source.widgets
            .firstWhere((component) => component.name == name)
            .sample;
      case ComponentType.elements:
      case ComponentType.uis:
        throw UnsupportedError('$type has no sample widget');
    }
  }

  Component _fromComponentModel(ComponentModel model) {
    return Component(
      name: model.name,
      type: model.type,
      icon: model.icon,
      videoId: model.videoId,
    );
  }

  List<Component> _getElements(Locale locale) {
    final l10n = lookupAppLocalizations(locale);

    return <Component>[
      Component(
        name: l10n.customPopupMenu,
        type: ComponentType.elements,
        fileName: 'custom_popup_menu',
      ),
      Component(
        name: l10n.gaps,
        type: ComponentType.elements,
        fileName: 'gaps',
      ),
      Component(
        name: l10n.imageLoader,
        type: ComponentType.elements,
        fileName: 'image_loader',
      ),
      Component(
        name: l10n.infiniteGridView,
        type: ComponentType.elements,
        fileName: 'infinite_grid_view',
      ),
      Component(
        name: l10n.loadingButton,
        type: ComponentType.elements,
        fileName: 'loading_button',
      ),
      Component(
        name: l10n.loadingDialog,
        type: ComponentType.elements,
        fileName: 'loading_dialog',
      ),
      Component(
        name: l10n.loadingScreen,
        type: ComponentType.elements,
        fileName: 'loading_screen',
      ),
      Component(
        name: l10n.pagination,
        type: ComponentType.elements,
        fileName: 'pagination',
      ),
      Component(
        name: l10n.passwordField,
        type: ComponentType.elements,
        fileName: 'password_field',
      ),
    ];
  }

  List<Component> _getUis(Locale locale) {
    final l10n = lookupAppLocalizations(locale);

    return <Component>[
      Component(
        name: l10n.chatScreen,
        type: ComponentType.uis,
        fileName: 'chat_screen',
      ),
      Component(
        name: l10n.emailsApp,
        type: ComponentType.uis,
        fileName: 'emails_app',
      ),
      Component(
        name: l10n.loginScreen,
        type: ComponentType.uis,
        fileName: 'login_screen',
      ),
      Component(
        name: l10n.loginScreenWithBackgroundImage,
        type: ComponentType.uis,
        fileName: 'login_with_background_image_screen',
      ),
      Component(
        name: l10n.phoneVerificationScreen,
        type: ComponentType.uis,
        fileName: 'phone_verification_screen',
      ),
    ];
  }
}
