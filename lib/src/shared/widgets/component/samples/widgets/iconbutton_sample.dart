import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IconButtonSample(),
    ),
  );
}

class IconButtonSample extends StatelessWidget {
  const IconButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Wrap(
          spacing: 12.0,
          children: <Widget>[
            FavoriteButtonWidget(),
            SettingButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class FavoriteButtonWidget extends StatefulWidget {
  const FavoriteButtonWidget({super.key});

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final icon = _isFavorite ? Icons.favorite : Icons.favorite_border;

    return Wrap(
      direction: Axis.vertical,
      spacing: 4.0,
      children: <Widget>[
        IconButton(
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
          icon: Icon(
            icon,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(
            icon,
          ),
        ),
      ],
    );
  }
}

class SettingButtonWidget extends StatefulWidget {
  const SettingButtonWidget({super.key});

  @override
  State<SettingButtonWidget> createState() => _SettingButtonWidgetState();
}

class _SettingButtonWidgetState extends State<SettingButtonWidget> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    final icon = _checked ? Icons.settings : Icons.settings_outlined;
    final iconColor = _checked ? Colors.white : null;

    return Wrap(
      direction: Axis.vertical,
      spacing: 4.0,
      children: <Widget>[
        IconButton(
          onPressed: () {
            setState(() {
              _checked = !_checked;
            });
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              _checked ? Colors.blue : Colors.grey.shade200,
            ),
          ),
          color: iconColor,
          icon: Icon(
            icon,
          ),
        ),
        IconButton(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Colors.grey.shade200,
            ),
          ),
          color: iconColor,
          icon: Icon(
            icon,
          ),
        ),
      ],
    );
  }
}
