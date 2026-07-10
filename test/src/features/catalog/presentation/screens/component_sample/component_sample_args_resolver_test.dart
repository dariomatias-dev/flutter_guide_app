import 'package:flutter/material.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_args_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resolve builds ComponentSampleArgs with resolved file path', () {
    const sample = SizedBox();

    final args = ComponentSampleArgsResolver.resolve(
      title: 'Card',
      folder: 'widgets',
      fileName: 'card',
      componentName: 'Card',
      sample: sample,
    );

    expect(args.title, 'Card');
    expect(
      args.filePath,
      'lib/src/features/catalog/data/samples/sample_components/'
      'widgets/card_sample.dart',
    );
    expect(args.componentName, 'Card');
    expect(args.sample, sample);
    expect(args.popupMenuItems, isNull);
  });

  test('resolve forwards popupMenuItems when provided', () {
    const popupMenuItems = <PopupMenuEntry<dynamic>>[
      PopupMenuItem<void>(child: Text('Item')),
    ];

    final args = ComponentSampleArgsResolver.resolve(
      title: 'ShowDialog',
      folder: 'functions',
      fileName: 'showdialog',
      componentName: 'showDialog',
      sample: const SizedBox(),
      popupMenuItems: popupMenuItems,
    );

    expect(args.popupMenuItems, popupMenuItems);
  });
}
