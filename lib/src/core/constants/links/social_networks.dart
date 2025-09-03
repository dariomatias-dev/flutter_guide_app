import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_guide/src/core/constants/links/app_links.dart';

import 'package:flutter_guide/src/shared/models/social_network_model.dart';

const socialNetworks = <SocialNetworkModel>[
  SocialNetworkModel(
    icon: FontAwesomeIcons.laptopCode,
    url: AppLinks.myWebsite,
  ),
  SocialNetworkModel(
    icon: FontAwesomeIcons.linkedinIn,
    url: AppLinks.linkedIn,
  ),
  SocialNetworkModel(
    icon: FontAwesomeIcons.github,
    url: AppLinks.github,
  ),
  SocialNetworkModel(
    icon: FontAwesomeIcons.instagram,
    url: AppLinks.instagram,
  ),
];
