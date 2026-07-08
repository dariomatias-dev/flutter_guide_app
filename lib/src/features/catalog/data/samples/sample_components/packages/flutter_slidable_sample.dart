import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const _actions = <_SlidableActionTemplate>[
  _SlidableActionTemplate(
    backgroundColor: Colors.blue,
    icon: Icons.edit,
  ),
  _SlidableActionTemplate(
    backgroundColor: Colors.red,
    icon: Icons.delete,
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSlidableSample(),
    ),
  );
}

/// Sample demonstrating `FlutterSlidableSample`.
class FlutterSlidableSample extends StatelessWidget {
  /// Creates a [FlutterSlidableSample].
  const FlutterSlidableSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Column(
          children: <Widget>[
            _FlutterSlidableTemplate(
              title: 'Flutter Slidable Motion: Scroll',
              startActions: _actions,
            ),
            _FlutterSlidableDividir(),
            _FlutterSlidableTemplate(
              title: 'Flutter Slidable Motion: Drawer',
              motion: DrawerMotion(),
              startActions: _actions,
            ),
            _FlutterSlidableDividir(),
            _FlutterSlidableTemplate(
              title: 'Flutter Slidable Motion: Stretch',
              motion: StretchMotion(),
              startActions: _actions,
            ),
            _FlutterSlidableDividir(),
            _FlutterSlidableTemplate(
              title: 'Flutter Slidable With End Actions',
              endActions: _actions,
            ),
            _FlutterSlidableDividir(),
            _FlutterSlidableTemplate(
              title: 'Flutter Slidable With Start And End Actions',
              startActions: _actions,
              endActions: _actions,
            ),
          ],
        ),
      ),
    );
  }
}

class _FlutterSlidableTemplate extends StatelessWidget {
  const _FlutterSlidableTemplate({
    required this.title,
    this.motion,
    this.startActions,
    this.endActions,
  });

  /// The [title].
  final String title;

  /// The [motion].
  final Widget? motion;

  /// The [startActions].
  final List<_SlidableActionTemplate>? startActions;

  /// The [endActions].
  final List<_SlidableActionTemplate>? endActions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Slidable(
          startActionPane: startActions != null
              ? ActionPane(
                  motion: motion ?? const ScrollMotion(),
                  children: startActions!,
                )
              : null,
          endActionPane: endActions != null
              ? ActionPane(
                  motion: motion ?? const ScrollMotion(),
                  children: endActions!,
                )
              : null,
          child: ListTile(
            tileColor: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade100
                : Colors.grey.shade900,
            title: const Text('Flutter Slidable'),
          ),
        ),
      ],
    );
  }
}

class _SlidableActionTemplate extends StatelessWidget {
  const _SlidableActionTemplate({
    required this.backgroundColor,
    required this.icon,
  });

  /// The [backgroundColor].
  final Color backgroundColor;

  /// The [icon].
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (context) {},
      backgroundColor: backgroundColor,
      icon: icon,
    );
  }
}

class _FlutterSlidableDividir extends StatelessWidget {
  /// Creates a [_FlutterSlidableDividir].
  const _FlutterSlidableDividir();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Divider(
        color: Colors.grey.shade200,
      ),
    );
  }
}
