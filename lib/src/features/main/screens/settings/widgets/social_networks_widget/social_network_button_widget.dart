part of 'social_networks_widget.dart';

class SocialNetworkButtonWidget extends StatelessWidget {
  const SocialNetworkButtonWidget({
    super.key,
    required this.socialNetwork,
  });

  final SocialNetworkModel socialNetwork;

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return IconButton(
      onPressed: () {
        openUrl(
          () => context,
          socialNetwork.url,
        );
      },
      highlightColor: Colors.blue.withOpacity(0.07),
      hoverColor: Colors.blue.withOpacity(0.08),
      icon: ValueListenableBuilder(
        valueListenable: themeController,
        builder: (context, value, child) {
          return FaIcon(
            socialNetwork.icon,
            color: themeController.theme.colorScheme.primary,
            size: 24.0,
          );
        },
      ),
    );
  }
}
