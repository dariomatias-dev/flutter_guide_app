import 'package:flutter/material.dart';
import 'package:scroll_infinity/scroll_infinity.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_components/elements.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/uis.dart';
import 'package:flutter_guide/src/core/constants/constants.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';

import 'package:flutter_guide/src/shared/models/interface_model.dart';
import 'package:flutter_guide/src/shared/widgets/banner_ad_widget.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';

const _pageSize = 18;

class InterfaceCatalogScreen extends StatefulWidget {
  const InterfaceCatalogScreen({
    super.key,
    required this.elementType,
  });

  final InterfaceTypeEnum elementType;

  @override
  State<InterfaceCatalogScreen> createState() => _InterfaceCatalogScreenState();
}

class _InterfaceCatalogScreenState extends State<InterfaceCatalogScreen> {
  final _allInterfaces = <InterfaceModel>[];

  Future<List<InterfaceModel>> _loadData(int pageIndex) async {
    final start = pageIndex * _pageSize;
    final end = start + _pageSize;
    final nextPageItems = _allInterfaces.sublist(
      start,
      end > _allInterfaces.length ? _allInterfaces.length : end,
    );

    return nextPageItems;
  }

  @override
  void didChangeDependencies() {
    final isUi = widget.elementType == InterfaceTypeEnum.ui;
    _allInterfaces.addAll(
      (isUi ? getUis : getElements)(context),
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final isUi = widget.elementType == InterfaceTypeEnum.ui;

    return Scaffold(
      appBar: StandardAppBarWidget(
        titleName: isUi ? 'UIs' : 'Elements',
      ),
      body: ScrollInfinity<InterfaceModel?>(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        maxItems: 18,
        interval: adInterval,
        loadData: _loadData,
        itemBuilder: (value, index) {
          if (value == null) {
            return const BannerAdWidget();
          }

          return ListTileItemWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ComponentSampleScreen(
                      title: value.name,
                      filePath:
                          'lib/src/shared/widgets/interface_catalog/samples/${isUi ? 'uis' : 'elements'}/${value.fileName}_sample.dart',
                      sample: value.component,
                    );
                  },
                ),
              );
            },
            title: value.name,
            trailingWidgets: const <Widget>[
              Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 26.0,
              ),
            ],
          );
        },
      ),
    );
  }
}
