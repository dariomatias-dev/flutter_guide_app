import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_names/package_names.dart';

// Samples
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/awesome_snackbar_content_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/battery_plus_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/bottom_navy_bar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/cached_network_image_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/carousel_slider_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/circular_countdown_timer_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/device_info_plus_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/dio_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/dotted_border_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/flutter_animate_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/flutter_chat_bubble_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/flutter_rating_bar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/flutter_slidable_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/flutter_spinkit_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/flutter_svg_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/flutter_syntax_highlighter_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/font_awesome_flutter_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/glass_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/google_fonts_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/google_mobile_ads_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/http_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/icons_plus_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/infinite_scroll_pagination_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/like_button_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/loading_animation_widget_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/loading_indicator_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/msh_checkbox_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/network_info_plus_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/photo_view_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/pinput_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/salomon_bottom_bar_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/scroll_infinity_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/share_plus_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/shared_preferences_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/side_sheet_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/smooth_page_indicator_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/toastification_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/url_launcher_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/uuid_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/packages/video_player_sample.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

// Models
import 'package:flutter_guide/src/shared/models/component_model/component_model.dart';
import 'package:flutter_guide/src/shared/models/component_summary_mode/component_summary_mode.dart';
import 'package:flutter_guide/src/shared/models/widget_infos_model/component_infos_model.dart';

const packages = <PackageModel>[
  PackageModel(
    name: PackageNames.awesomeSnackbarContentPackage,
    icon: Icons.message_outlined,
    sample: AwesomeSnackbarContentSample(),
  ),
  PackageModel(
    name: PackageNames.batteryPlusPackage,
    icon: Icons.battery_std_rounded,
    sample: BatteryPlusSample(),
  ),
  PackageModel(
    name: PackageNames.bottomNavyBarPackage,
    icon: Icons.view_carousel,
    sample: BottomNavyBarSample(),
  ),
  PackageModel(
    name: PackageNames.cachedNetworkImagePackage,
    icon: Icons.image_outlined,
    sample: CachedNetworkImageSample(),
  ),
  PackageModel(
    name: PackageNames.carouselSliderPackage,
    icon: Icons.view_carousel,
    sample: CarouselSliderSample(),
  ),
  PackageModel(
    name: PackageNames.circularCountdownTimerPackage,
    icon: Icons.hourglass_empty,
    sample: CircularCountdownTimerSample(),
  ),
  PackageModel(
    name: PackageNames.deviceInfoPlusPackage,
    icon: Icons.devices_rounded,
    sample: DeviceInfoPlusSample(),
  ),
  PackageModel(
    name: PackageNames.dioPackage,
    icon: Icons.wifi,
    sample: DioSample(),
  ),
  PackageModel(
    name: PackageNames.dottedBorderPackage,
    icon: Icons.border_clear_outlined,
    sample: DottedBorderSample(),
  ),
  PackageModel(
    name: PackageNames.flutterAnimatePackage,
    icon: Icons.animation,
    sample: FlutterAnimateSample(),
  ),
  PackageModel(
    name: PackageNames.flutterChatBubblePackage,
    icon: Icons.chat_outlined,
    sample: FlutterChatBubbleSample(),
  ),
  PackageModel(
    name: PackageNames.flutterRatingBarPackage,
    icon: Icons.star,
    videoId: 'VdkRy3yZiPo',
    sample: FlutterRatingBarSample(),
  ),
  PackageModel(
    name: PackageNames.flutterSlidablePackage,
    icon: Icons.more_horiz,
    videoId: 'QFcFEpFmNJ8',
    sample: FlutterSlidableSample(),
  ),
  PackageModel(
    name: PackageNames.flutterSpinkitPackage,
    icon: Icons.cached,
    sample: FlutterSpinkitSample(),
  ),
  PackageModel(
    name: PackageNames.flutterSvgPackage,
    icon: Icons.image,
    sample: FlutterSvgSample(),
  ),
  PackageModel(
    name: PackageNames.flutterSyntaxHighlighterPackage,
    icon: Icons.description_outlined,
    sample: FlutterSyntaxHighlighterSample(),
  ),
  PackageModel(
    name: PackageNames.fontAwesomeFlutterPackage,
    icon: Icons.circle_outlined,
    videoId: 'TOAyjIAsT7o',
    sample: FontAwesomeFlutterSample(),
  ),
  PackageModel(
    name: PackageNames.glassPackage,
    icon: Icons.blur_on,
    sample: GlassSample(),
  ),
  PackageModel(
    name: PackageNames.googleFontsPackage,
    icon: Icons.font_download_outlined,
    videoId: '8Vzv2CdbEY0',
    sample: GoogleFontsSample(),
  ),
  PackageModel(
    name: PackageNames.googleMobileAdsPackage,
    icon: Icons.monetization_on_outlined,
    sample: GoogleMobileAdsSample(),
  ),
  PackageModel(
    name: PackageNames.httpPackage,
    icon: Icons.wifi,
    sample: HttpSample(),
  ),
  PackageModel(
    name: PackageNames.iconsPlusPackage,
    icon: Icons.circle_outlined,
    sample: IconsPlusSample(),
  ),
  PackageModel(
    name: PackageNames.infiniteScrollPaginationPackage,
    icon: Icons.swap_vert,
    sample: InfiniteScrollPaginationSample(),
  ),
  PackageModel(
    name: PackageNames.likeButtonPackage,
    icon: Icons.thumb_up,
    sample: LikeButtonSample(),
  ),
  PackageModel(
    name: PackageNames.loadingAnimationWidgetPackage,
    icon: Icons.cached,
    sample: LoadingAnimationWidgetSample(),
  ),
  PackageModel(
    name: PackageNames.loadingIndicatorPackage,
    icon: Icons.cached,
    sample: LoadingIndicatorSample(),
  ),
  PackageModel(
    name: PackageNames.mshCheckboxPackage,
    icon: Icons.check_box_outlined,
    sample: MshCheckboxSample(),
  ),
  PackageModel(
    name: PackageNames.networkInfoPlusPackage,
    icon: Icons.wifi_outlined,
    sample: NetworkInfoPlusSample(),
  ),
  PackageModel(
    name: PackageNames.photoViewPackage,
    icon: Icons.photo_outlined,
    sample: PhotoViewSample(),
  ),
  PackageModel(
    name: PackageNames.pinputPackage,
    icon: Icons.password,
    sample: PinputSample(),
  ),
  PackageModel(
    name: PackageNames.salomonBottomBarPackage,
    icon: Icons.view_carousel,
    sample: SalomonBottomBarSample(),
  ),
  PackageModel(
    name: PackageNames.scrollInfinityPackage,
    icon: Icons.loop,
    sample: ScrollInfinitySample(),
  ),
  PackageModel(
    name: PackageNames.sharePlusPackage,
    icon: Icons.share,
    sample: SharePlusSample(),
  ),
  PackageModel(
    name: PackageNames.sharedPreferencesPackage,
    icon: Icons.storage,
    videoId: 'sa_U0jffQII',
    sample: SharedPreferencesSample(),
  ),
  PackageModel(
    name: PackageNames.sideSheetPackage,
    icon: Icons.view_sidebar_outlined,
    sample: SideSheetSample(),
  ),
  PackageModel(
    name: PackageNames.smoothPageIndicatorPackage,
    icon: Icons.view_carousel,
    sample: SmoothPageIndicatorSample(),
  ),
  PackageModel(
    name: PackageNames.toastificationPackage,
    icon: Icons.notifications,
    sample: ToastificationSample(),
  ),
  PackageModel(
    name: PackageNames.urlLauncherPackage,
    icon: Icons.link,
    videoId: 'qYxRYB1oszw',
    sample: UrlLauncherSample(),
  ),
  PackageModel(
    name: PackageNames.uuidPackage,
    icon: Icons.vpn_key,
    sample: UuidSample(),
  ),
  PackageModel(
    name: PackageNames.videoPlayerPackage,
    icon: Icons.image_outlined,
    sample: VideoPlayerSample(),
  ),
];

PackageInfosModel getPackageInfos() {
  final packageNames = <String>[];

  Map<String, PackageSummaryModel> samples = {};

  for (var package in packages) {
    packageNames.add(package.name);

    samples[package.name] = PackageSummaryModel(
      name: package.name,
      type: ComponentType.package,
      videoId: package.videoId,
      sample: package.sample,
    );
  }

  return PackageInfosModel(
    componentNames: packageNames,
    samples: samples,
  );
}
