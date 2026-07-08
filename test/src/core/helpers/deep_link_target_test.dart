import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/helpers/deep_link_target.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseDeepLink', () {
    test('returns InvalidLinkTarget when fewer than two segments', () {
      expect(
        parseDeepLink(Uri.parse('app://host/widgets')),
        isA<InvalidLinkTarget>(),
      );
      expect(parseDeepLink(Uri.parse('app://host')), isA<InvalidLinkTarget>());
    });

    test('maps elements to an element InterfaceTarget', () {
      final target = parseDeepLink(Uri.parse('app://host/elements/gaps'));

      expect(target, isA<InterfaceTarget>());
      target as InterfaceTarget;
      expect(target.interfaceType, InterfaceTypeEnum.element);
      expect(target.folder, 'elements');
      expect(target.componentName, 'gaps');
    });

    test('maps uis to a ui InterfaceTarget', () {
      final target = parseDeepLink(Uri.parse('app://host/uis/chat_screen'));

      expect(target, isA<InterfaceTarget>());
      target as InterfaceTarget;
      expect(target.interfaceType, InterfaceTypeEnum.ui);
      expect(target.folder, 'uis');
      expect(target.componentName, 'chat_screen');
    });

    test('maps widgets to a widget ComponentTarget on elements tab 0', () {
      final target = parseDeepLink(Uri.parse('app://host/widgets/Container'));

      expect(target, isA<ComponentTarget>());
      target as ComponentTarget;
      expect(target.componentType, ComponentType.widget);
      expect(target.componentName, 'Container');
      expect(target.navigationIndex, 1);
      expect(target.elementsTabIndex, 0);
    });

    test('maps functions to a function ComponentTarget on elements tab 1', () {
      final target =
          parseDeepLink(Uri.parse('app://host/functions/showDialog'));

      expect(target, isA<ComponentTarget>());
      target as ComponentTarget;
      expect(target.componentType, ComponentType.function);
      expect(target.navigationIndex, 1);
      expect(target.elementsTabIndex, 1);
    });

    test('maps packages to a package ComponentTarget with no elements tab', () {
      final target = parseDeepLink(Uri.parse('app://host/packages/dio'));

      expect(target, isA<ComponentTarget>());
      target as ComponentTarget;
      expect(target.componentType, ComponentType.package);
      expect(target.navigationIndex, 2);
      expect(target.elementsTabIndex, isNull);
    });

    test('returns UnknownTarget for an unrecognized type', () {
      final target = parseDeepLink(Uri.parse('app://host/bogus/thing'));

      expect(target, isA<UnknownTarget>());
      target as UnknownTarget;
      expect(target.type, 'bogus');
      expect(target.componentName, 'thing');
    });
  });
}
