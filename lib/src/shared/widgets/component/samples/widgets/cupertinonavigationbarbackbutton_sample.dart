import 'package:flutter/cupertino.dart';

class CupertinoNavigationBarBackButtonSample extends StatelessWidget {
  const CupertinoNavigationBarBackButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CupertinoNavigationBarBackButton(),
    );
  }
}
