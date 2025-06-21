import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuAnchorSample(),
    ),
  );
}

class MenuAnchorSample extends StatefulWidget {
  const MenuAnchorSample({super.key});

  @override
  State<MenuAnchorSample> createState() => _MenuAnchorSampleState();
}

class _MenuAnchorSampleState extends State<MenuAnchorSample> {
  final _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MenuAnchor(
          controller: _menuController,
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () {},
              child: const Text('Dart'),
            ),
            const MenuItemButton(
              child: Text('Kotlin'),
            ),
            SubmenuButton(
              menuChildren: <MenuItemButton>[
                MenuItemButton(
                  onPressed: () {},
                  child: const Text('Doc'),
                ),
                const MenuItemButton(
                  child: Text('Samples'),
                ),
              ],
              child: const Text('Flutter'),
            ),
          ],
          onOpen: () {},
          child: IconButton(
            onPressed: () {
              _menuController.isOpen
                  ? _menuController.close()
                  : _menuController.open();
            },
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ),
      ),
    );
  }
}
