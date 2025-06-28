import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_guide/src/core/constants/links/social_networks.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/shared/models/social_network_model.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';

part 'social_network_button_widget.dart';

class SocialNetworksWidget extends StatelessWidget {
  const SocialNetworksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 32.0,
        bottom: 20.0,
      ),
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 16.0,
        children: List.generate(
          socialNetworks.length,
          (index) {
            return SocialNetworkButtonWidget(
              socialNetwork: socialNetworks[index],
            );
          },
        ),
      ),
    );
  }
}
