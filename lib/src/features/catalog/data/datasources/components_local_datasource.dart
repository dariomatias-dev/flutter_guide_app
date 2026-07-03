import 'dart:ui';

import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/functions.dart'
    as functions_source;
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/packages.dart'
    as packages_source;
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/widgets.dart'
    as widgets_source;
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component_entity.dart';
import 'package:flutter_guide/src/shared/models/component_model.dart';

class ComponentsLocalDatasource {
  List<ComponentEntity> getByType(
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

  ComponentEntity getByName({
    required ComponentType type,
    required String name,
    required Locale locale,
  }) {
    return getByType(type, locale: locale).firstWhere(
      (component) => component.name == name,
    );
  }

  ComponentEntity _fromComponentModel(ComponentModel model) {
    return ComponentEntity(
      name: model.name,
      type: model.type,
      icon: model.icon,
      videoId: model.videoId,
    );
  }

  List<ComponentEntity> _getElements(Locale locale) {
    final l10n = lookupAppLocalizations(locale);

    return <ComponentEntity>[
      ComponentEntity(
        name: l10n.customPopupMenu,
        type: ComponentType.elements,
        fileName: 'custom_popup_menu',
      ),
      ComponentEntity(
        name: l10n.gaps,
        type: ComponentType.elements,
        fileName: 'gaps',
      ),
      ComponentEntity(
        name: l10n.imageLoader,
        type: ComponentType.elements,
        fileName: 'image_loader',
      ),
      ComponentEntity(
        name: l10n.infiniteGridView,
        type: ComponentType.elements,
        fileName: 'infinite_grid_view',
      ),
      ComponentEntity(
        name: l10n.loadingButton,
        type: ComponentType.elements,
        fileName: 'loading_button',
      ),
      ComponentEntity(
        name: l10n.loadingDialog,
        type: ComponentType.elements,
        fileName: 'loading_dialog',
      ),
      ComponentEntity(
        name: l10n.loadingScreen,
        type: ComponentType.elements,
        fileName: 'loading_screen',
      ),
      ComponentEntity(
        name: l10n.pagination,
        type: ComponentType.elements,
        fileName: 'pagination',
      ),
      ComponentEntity(
        name: l10n.passwordField,
        type: ComponentType.elements,
        fileName: 'password_field',
      ),
    ];
  }

  List<ComponentEntity> _getUis(Locale locale) {
    final l10n = lookupAppLocalizations(locale);

    return <ComponentEntity>[
      ComponentEntity(
        name: l10n.chatScreen,
        type: ComponentType.uis,
        fileName: 'chat_screen',
      ),
      ComponentEntity(
        name: l10n.emailsApp,
        type: ComponentType.uis,
        fileName: 'emails_app',
      ),
      ComponentEntity(
        name: l10n.loginScreen,
        type: ComponentType.uis,
        fileName: 'login_screen',
      ),
      ComponentEntity(
        name: l10n.loginScreenWithBackgroundImage,
        type: ComponentType.uis,
        fileName: 'login_with_background_image_screen',
      ),
      ComponentEntity(
        name: l10n.phoneVerificationScreen,
        type: ComponentType.uis,
        fileName: 'phone_verification_screen',
      ),
    ];
  }
}
