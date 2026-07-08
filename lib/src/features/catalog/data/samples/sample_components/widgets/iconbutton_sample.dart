import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IconButtonSample(),
    ),
  );
}

/// Sample demonstrating `IconButtonSample`.
class IconButtonSample extends StatelessWidget {
  /// Creates a [IconButtonSample].
  const IconButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Wrap(
          spacing: 12,
          children: <Widget>[
            FavoriteButtonWidget(),
            SettingButtonWidget(),
          ],
        ),
      ),
    );
  }
}

/// Sample demonstrating `FavoriteButtonWidget`.
class FavoriteButtonWidget extends StatefulWidget {
  /// Creates a [FavoriteButtonWidget].
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
      spacing: 4,
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

/// Sample demonstrating `SettingButtonWidget`.
class SettingButtonWidget extends StatefulWidget {
  /// Creates a [SettingButtonWidget].
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
      spacing: 4,
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
