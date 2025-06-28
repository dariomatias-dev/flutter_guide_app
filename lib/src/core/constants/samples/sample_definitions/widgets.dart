import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_names/widget_names.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

// Models
import 'package:flutter_guide/src/shared/models/component_model/component_model.dart';
import 'package:flutter_guide/src/shared/models/component_summary_mode/component_summary_mode.dart';
import 'package:flutter_guide/src/shared/models/widget_infos_model/component_infos_model.dart';

// Samples
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/actionchip_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/alertdialog_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/align_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/animatedalign_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/animatedcontainer_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/animatedopacity_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/appbar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/autocomplete_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/backbutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/backdropfilter_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/badge_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/banner_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/bottomappbar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/bottomnavigationbar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/card_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/center_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/checkbox_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/checkboxlisttile_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/chip_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/choicechip_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/circleavatar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/circularprogressindicator_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/clipoval_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/cliprrect_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/colorfiltered_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/column_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/constrainedbox_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/container_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/cupertinoactivityindicator_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/cupertinoalertdialog_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/cupertinobutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/cupertinolisttile_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/cupertinonavigationbar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/cupertinonavigationbarbackbutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/cupertinopagescaffold_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/cupertinoradio_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/decoratedbox_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/dialog_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/dismissible_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/divider_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/drawer_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/dropdownbutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/editabletext_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/elevatedbutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/expanded_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/expansiontile_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/filledbutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/filterchip_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/floatingactionbutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/flutterlogo_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/form_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/futurebuilder_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/gesturedetector_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/gridview_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/iconbutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/ignorepointer_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/image_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/indexedstack_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/inkwell_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/inputchip_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/interactiveviewer_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/linearprogressindicator_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/listenablebuilder_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/listtile_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/listview_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/menuanchor_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/navigationbar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/navigationrail_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/opacity_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/outlinedbutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/pageview_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/placeholder_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/popupmenubutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/radio_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/radiolisttile_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/rangeslider_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/reorderablelistview_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/richtext_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/row_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/safearea_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/scaffold_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/segmentedbutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/selectabletext_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/simpledialog_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/singlechildscrollview_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/sizedbox_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/slider_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/snackbar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/spacer_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/stack_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/switch_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/switchlisttile_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/tabbar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/text_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/textbutton_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/textfield_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/textformfield_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/material_banner_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/theme_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/togglebuttons_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/tooltip_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/valuelistenablebuilder_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/visibility_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/widgets/wrap_sample.dart';

const widgets = <WidgetModel>[
  WidgetModel(
    name: WidgetNames.actionChipMaterial,
    icon: Icons.label_outline,
    sample: ActionChipSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.alertDialogMaterial,
    icon: Icons.chat_bubble_outline,
    videoId: '75CsnyRXf5I',
    sample: AlertDialogSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.alignWidget,
    icon: Icons.center_focus_strong,
    videoId: 'g2E7yl3MwMk',
    sample: AlignSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.animatedAlignWidget,
    icon: Icons.center_focus_strong,
    sample: AnimatedAlignSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.animatedContainerWidget,
    icon: Icons.animation,
    sample: AnimatedContainerSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.animatedOpacityWidget,
    icon: Icons.opacity,
    videoId: 'QZAvjqOqiLY',
    sample: AnimatedOpacitySample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.appBarMaterial,
    icon: Icons.menu,
    sample: AppBarSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.autocompleteMaterial,
    icon: Icons.search,
    videoId: '-Nny8kzW380',
    sample: AutocompleteSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.backButtonMaterial,
    icon: Icons.arrow_back,
    sample: BackButtonSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.backdropFilterWidget,
    icon: Icons.opacity,
    videoId: 'dYRs7Q1vfYI',
    sample: BackdropFilterSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.badgeMaterial,
    icon: Icons.badge_outlined,
    sample: BadgeSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.bannerWidget,
    icon: Icons.flag,
    sample: BannerSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.bottomAppBarMaterial,
    icon: Icons.view_carousel,
    sample: BottomAppBarSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.bottomNavigationBarMaterial,
    icon: Icons.view_carousel,
    sample: BottomNavigationBarSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.cardMaterial,
    icon: Icons.dashboard_outlined,
    sample: CardSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.centerWidget,
    icon: Icons.center_focus_strong_outlined,
    sample: CenterSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.checkboxMaterial,
    icon: Icons.check_box,
    sample: CheckboxSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.checkboxListTileMaterial,
    icon: Icons.check_box,
    videoId: 'RkSqPAn9szs',
    sample: CheckboxListTileSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.chipMaterial,
    icon: Icons.label_outline,
    sample: ChipSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.choiceChipMaterial,
    icon: Icons.label_outline,
    sample: ChoiceChipSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.circleAvatarMaterial,
    icon: Icons.person,
    sample: CircleAvatarSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.circularProgressIndicatorMaterial,
    icon: Icons.cached,
    videoId: 'O-rhXZLtpv0',
    sample: CircularProgressIndicatorSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.clipOvalWidget,
    icon: Icons.crop,
    sample: ClipOvalSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.clipRRectWidget,
    icon: Icons.crop,
    sample: ClipRRectSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.colorFilteredWidget,
    icon: Icons.brush,
    videoId: 'F7Cll22Dno8',
    sample: ColorFilteredSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.columnWidget,
    icon: Icons.view_column,
    sample: ColumnSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.constrainedBoxWidget,
    icon: Icons.border_all,
    videoId: 'o2KveVr7adg',
    sample: ConstrainedBoxSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.containerWidget,
    icon: Icons.crop_square,
    videoId: 'c1xLMaTUWCY',
    sample: ContainerSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.cupertinoActivityIndicatorCupertino,
    icon: Icons.cached,
    videoId: 'AENVH-ZqKDQ',
    sample: CupertinoActivityIndicatorSample(),
    type: ComponentType.cupertino,
  ),
  WidgetModel(
    name: WidgetNames.cupertinoAlertDialogCupertino,
    icon: Icons.chat_bubble_outline,
    videoId: '75CsnyRXf5I',
    sample: CupertinoAlertDialogSample(),
    type: ComponentType.cupertino,
  ),
  WidgetModel(
    name: WidgetNames.cupertinoButtonCupertino,
    icon: Icons.crop_16_9,
    sample: CupertinoButtonSample(),
    type: ComponentType.cupertino,
  ),
  WidgetModel(
    name: WidgetNames.cupertinoListTileCupertino,
    icon: Icons.list_alt,
    sample: CupertinoListTileSample(),
    type: ComponentType.cupertino,
  ),
  WidgetModel(
    name: WidgetNames.cupertinoNavigationBarCupertino,
    icon: Icons.menu,
    sample: CupertinoNavigationBarSample(),
    type: ComponentType.cupertino,
  ),
  WidgetModel(
    name: WidgetNames.cupertinoNavigationBarBackButtonCupertino,
    icon: Icons.arrow_back_ios_new_rounded,
    sample: CupertinoNavigationBarBackButtonSample(),
    type: ComponentType.cupertino,
  ),
  WidgetModel(
    name: WidgetNames.cupertinoPageScaffoldCupertino,
    icon: Icons.dashboard,
    sample: CupertinoPageScaffoldSample(),
    type: ComponentType.cupertino,
  ),
  WidgetModel(
    name: WidgetNames.cupertinoRadioCupertino,
    icon: Icons.radio_button_checked,
    sample: CupertinoRadioSample(),
    type: ComponentType.cupertino,
  ),
  // WidgetModel(
  //   name: WidgetNames.cupertinoSliderCupertino,
  //   icon: Icons.tune,
  //   videoId: 'ufb4gIPDmEs',
  //   sample: CupertinoSliderSample(),
  //   type: ComponentType.cupertino,
  // ),
  WidgetModel(
    name: WidgetNames.decoratedBoxWidget,
    icon: Icons.image,
    sample: DecoratedBoxSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.dialogMaterial,
    icon: Icons.chat_bubble_outline,
    sample: DialogSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.dismissibleMaterial,
    icon: Icons.delete_outline,
    videoId: 'iEMgjrfuc58',
    sample: DismissibleSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.dividerMaterial,
    icon: Icons.remove,
    videoId: '_liUC641Nmk',
    sample: DividerSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.drawerMaterial,
    icon: Icons.menu,
    videoId: 'WRj86iHihgY',
    sample: DrawerSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.dropdownButtonMaterial,
    icon: Icons.arrow_drop_down,
    videoId: 'ZzQ_PWrFihg',
    sample: DropdownButtonSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.editableTextWidget,
    icon: Icons.edit_outlined,
    sample: EditabletextSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.elevatedButtonMaterial,
    icon: Icons.crop_16_9,
    sample: ElevatedButtonSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.expandedWidget,
    icon: Icons.open_with,
    videoId: '_rnZaagadyo',
    sample: ExpandedSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.expansionTileMaterial,
    icon: Icons.keyboard_arrow_down_rounded,
    sample: ExpansionTileSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.filledButtonMaterial,
    icon: Icons.crop_16_9,
    sample: FilledButtonSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.filterChipMaterial,
    icon: Icons.label_outline,
    sample: FilterChipSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.floatingActionButtonMaterial,
    icon: Icons.add,
    sample: FloatingActionButtonSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.flutterLogoMaterial,
    icon: Icons.flutter_dash,
    videoId: 'aAmP-WcI6dg',
    sample: FlutterLogoSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.formWidget,
    icon: Icons.assignment_outlined,
    sample: FormSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.futureBuilderWidget,
    icon: Icons.hourglass_empty,
    videoId: 'zEdw_1B7JHY',
    sample: FutureBuilderSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.gestureDetectorWidget,
    icon: Icons.gesture,
    videoId: 'WhVXkCFPmK4',
    sample: GestureDetectorSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.gridViewWidget,
    icon: Icons.grid_3x3,
    sample: GridViewSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.iconButtonMaterial,
    icon: Icons.crop_16_9,
    sample: IconButtonSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.ignorePointerWidget,
    icon: Icons.block,
    videoId: 'qV9pqHWxYgI',
    sample: IgnorePointerSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.imageWidget,
    icon: Icons.image,
    videoId: '7oIAs-0G4mw',
    sample: ImageSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.indexedStackWidget,
    icon: Icons.layers,
    videoId: '_O0PPD1Xfbk',
    sample: IndexedStackSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.inkWellMaterial,
    icon: Icons.touch_app_outlined,
    sample: InkWellSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.inputChipMaterial,
    icon: Icons.label_outline,
    sample: InputChipSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.interactiveViewerWidget,
    icon: Icons.zoom_out_map,
    videoId: 'zrn7V3bMJvg',
    sample: InteractiveViewerSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.linearProgressIndicatorMaterial,
    icon: Icons.cached,
    videoId: 'O-rhXZLtpv0',
    sample: LinearProgressIndicatorSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.listenableBuilderWidget,
    icon: Icons.transform,
    sample: ListenableBuilderSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.listTileMaterial,
    icon: Icons.list_alt,
    videoId: 'l8dj0yPBvgQ',
    sample: ListTileSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.listViewWidget,
    icon: Icons.list,
    videoId: 'KJpkjHGiI5A',
    sample: ListViewSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.materialBannerMaterial,
    icon: Icons.flag_outlined,
    sample: MaterialBannerSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.menuAnchorMaterial,
    icon: Icons.search,
    sample: MenuAnchorSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.navigationBarMaterial,
    icon: Icons.view_carousel,
    videoId: 'DVGYddFaLv0',
    sample: NavigationBarSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.navigationRailMaterial,
    icon: Icons.view_carousel,
    videoId: 'y9xchtVTtqQ',
    sample: NavigationRailSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.opacityWidget,
    icon: Icons.opacity,
    videoId: '9hltevOHQBw',
    sample: OpacitySample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.outlinedButtonMaterial,
    icon: Icons.crop_16_9,
    sample: OutlinedButtonSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.pageViewWidget,
    icon: Icons.view_carousel,
    videoId: 'J1gE9xvph-A',
    sample: PageViewSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.placeholderWidget,
    icon: Icons.border_clear,
    videoId: 'LPe56fezmoo',
    sample: PlaceholderSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.popupMenuButtonMaterial,
    icon: Icons.more_vert,
    sample: PopupMenuButtonSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.radioMaterial,
    icon: Icons.radio_button_checked,
    sample: RadioSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.radioListTileMaterial,
    icon: Icons.radio_button_checked,
    sample: RadioListTileSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.rangeSliderMaterial,
    icon: Icons.tune,
    videoId: 'ufb4gIPDmEs',
    sample: RangeSliderSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.reorderableListViewMaterial,
    icon: Icons.drag_handle,
    videoId: '3fB1mxOsqJE',
    sample: ReorderableListViewSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.richTextWidget,
    icon: Icons.text_fields,
    videoId: 'rykDVh-QFfw',
    sample: RichTextSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.rowWidget,
    icon: Icons.view_week,
    sample: RowSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.safeAreaWidget,
    icon: Icons.border_outer,
    videoId: 'lkF0TQJO0bA',
    sample: SafeAreaSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.scaffoldMaterial,
    icon: Icons.dashboard,
    sample: ScaffoldSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.segmentedButtonMaterial,
    icon: Icons.linear_scale_sharp,
    sample: SegmentedButtonSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.selectableTextMaterial,
    icon: Icons.text_fields,
    videoId: 'ZSU3ZXOs6hc',
    sample: SelectableTextSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.simpleDialogMaterial,
    icon: Icons.chat_bubble_outline,
    sample: SimpleDialogSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.singleChildScrollViewWidget,
    icon: Icons.swap_vert,
    sample: SingleChildScrollViewSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.sizedBoxWidget,
    icon: Icons.crop_square,
    videoId: 'EHPu_DzRfqA',
    sample: SizedBoxSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.sliderMaterial,
    icon: Icons.tune,
    videoId: 'ufb4gIPDmEs',
    sample: SliderSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.snackBarMaterial,
    icon: Icons.info_outline,
    videoId: 'zpO6n_oZWw0',
    sample: SnackBarSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.spacerWidget,
    icon: Icons.linear_scale,
    videoId: '7FJgd7QN1zI',
    sample: SpacerSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.stackWidget,
    icon: Icons.layers,
    videoId: 'liEGSeD3Zt8',
    sample: StackSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.switchWidget,
    icon: Icons.toggle_on,
    sample: SwitchSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.switchListTileMaterial,
    icon: Icons.toggle_on,
    sample: SwitchListTileSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.tabBarSampleMaterial,
    icon: Icons.view_module,
    videoId: 'POtoEH-5l40',
    sample: TabBarSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.textWidget,
    icon: Icons.text_fields,
    sample: TextSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.textButtonMaterial,
    icon: Icons.text_fields,
    sample: TextButtonSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.textFieldMaterial,
    icon: Icons.edit,
    sample: TextFieldSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.textFormFieldMaterial,
    icon: Icons.edit,
    sample: TextFormFieldSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.themeMaterial,
    icon: Icons.color_lens_outlined,
    videoId: 'oTvQDJOBXmM',
    sample: ThemeSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.toggleButtonsMaterial,
    icon: Icons.check_box,
    videoId: 'kVEguaQWGAY',
    sample: ToggleButtonsSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.tooltipMaterial,
    icon: Icons.help_outline,
    videoId: 'EeEfD5fI-5Q',
    sample: TooltipSample(),
    type: ComponentType.material,
  ),
  WidgetModel(
    name: WidgetNames.valueListenableBuilderWidget,
    icon: Icons.transform,
    videoId: 's-ZG-jS5QHQ',
    sample: ValueListenableBuilderSample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.visibilityWidget,
    icon: Icons.visibility_outlined,
    sample: VisibilitySample(),
    type: ComponentType.widget,
  ),
  WidgetModel(
    name: WidgetNames.wrapWidget,
    icon: Icons.view_week,
    videoId: 'z5iw2SeFx2M',
    sample: WrapSample(),
    type: ComponentType.widget,
  ),
];

WidgetInfosModel getWidgetInfos() {
  final widgetNames = <String>[];
  Map<String, WidgetSummaryModel> samples = {};

  for (var widget in widgets) {
    widgetNames.add(
      widget.name,
    );

    samples[widget.name] = WidgetSummaryModel(
      name: widget.name,
      type: widget.type,
      videoId: widget.videoId,
      sample: widget.sample,
    );
  }

  return WidgetInfosModel(
    componentNames: widgetNames,
    samples: samples,
  );
}
