import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';

/// The routing decision derived from a deep link [Uri].
///
/// Pure data with no side effects, so it can be unit tested in isolation
/// from navigation and localization.
sealed class DeepLinkTarget {
  const DeepLinkTarget();
}

/// A link that does not carry enough path segments to be resolved.
class InvalidLinkTarget extends DeepLinkTarget {
  /// Creates an [InvalidLinkTarget].
  const InvalidLinkTarget();
}

/// A link that points to an interface catalog (elements or UIs).
class InterfaceTarget extends DeepLinkTarget {
  /// Creates an [InterfaceTarget].
  const InterfaceTarget({
    required this.interfaceType,
    required this.folder,
    required this.componentName,
  });

  /// The kind of interface being opened.
  final InterfaceTypeEnum interfaceType;

  /// The sample folder backing the interface.
  final String folder;

  /// The name of the targeted component.
  final String componentName;
}

/// A link that points to a component catalog entry.
class ComponentTarget extends DeepLinkTarget {
  /// Creates a [ComponentTarget].
  const ComponentTarget({
    required this.componentType,
    required this.componentName,
    required this.navigationIndex,
    this.elementsTabIndex,
  });

  /// The category of the targeted component.
  final ComponentType componentType;

  /// The name of the targeted component.
  final String componentName;

  /// The root navigation index to select.
  final int navigationIndex;

  /// The elements-screen tab to select, or `null` when not applicable.
  final int? elementsTabIndex;
}

/// A link whose type segment is not recognized.
class UnknownTarget extends DeepLinkTarget {
  /// Creates an [UnknownTarget].
  const UnknownTarget({
    required this.componentName,
    required this.type,
  });

  /// The name of the targeted component.
  final String componentName;

  /// The unrecognized type segment.
  final String type;
}

/// Resolves the deep link [uri] into a [DeepLinkTarget].
///
/// Only inspects the path segments; performs no navigation, existence
/// checks, or localization lookups.
DeepLinkTarget parseDeepLink(Uri uri) {
  if (uri.pathSegments.length < 2) {
    return const InvalidLinkTarget();
  }

  final type = uri.pathSegments[0];
  final componentName = uri.pathSegments[1];

  switch (type) {
    case 'elements':
      return InterfaceTarget(
        interfaceType: InterfaceTypeEnum.element,
        folder: 'elements',
        componentName: componentName,
      );
    case 'uis':
      return InterfaceTarget(
        interfaceType: InterfaceTypeEnum.ui,
        folder: 'uis',
        componentName: componentName,
      );
    case 'widgets':
      return ComponentTarget(
        componentType: ComponentType.widget,
        componentName: componentName,
        navigationIndex: 1,
        elementsTabIndex: 0,
      );
    case 'functions':
      return ComponentTarget(
        componentType: ComponentType.function,
        componentName: componentName,
        navigationIndex: 1,
        elementsTabIndex: 1,
      );
    case 'packages':
      return ComponentTarget(
        componentType: ComponentType.package,
        componentName: componentName,
        navigationIndex: 2,
      );
    default:
      return UnknownTarget(
        componentName: componentName,
        type: type,
      );
  }
}
