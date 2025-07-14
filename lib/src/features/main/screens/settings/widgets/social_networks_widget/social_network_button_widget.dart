part of 'social_networks_widget.dart';

class SocialNetworkButtonWidget extends StatelessWidget {
  const SocialNetworkButtonWidget({
    super.key,
    required this.socialNetwork,
  });

  final SocialNetworkModel socialNetwork;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        openUrl(
          () => context,
          socialNetwork.url,
        );
      },
      highlightColor: Colors.blue.withAlpha(18),
      hoverColor: Colors.blue.withAlpha(20),
      icon: FaIcon(
        socialNetwork.icon,
        color: Theme.of(context).colorScheme.primary,
        size: 24.0,
      ),
    );
  }
}
