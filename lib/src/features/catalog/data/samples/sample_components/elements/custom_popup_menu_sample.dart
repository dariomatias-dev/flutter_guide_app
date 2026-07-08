import 'package:flutter/material.dart';

/// A named alignment option for the popup menu.
class AlignmentModel {
  /// Creates a [AlignmentModel].
  const AlignmentModel({
    required this.name,
    required this.value,
  });

  /// The [name].
  final String name;

  /// The [value].
  final Alignment value;
}

/// Alignment options shown in the sample.
const alignments = <AlignmentModel>[
  AlignmentModel(
    name: 'Bottom Center',
    value: Alignment.bottomCenter,
  ),
  AlignmentModel(
    name: 'Bottom Left',
    value: Alignment.bottomLeft,
  ),
  AlignmentModel(
    name: 'Bottom Right',
    value: Alignment.bottomRight,
  ),
  AlignmentModel(
    name: 'Center',
    value: Alignment.center,
  ),
  AlignmentModel(
    name: 'Center Left',
    value: Alignment.centerLeft,
  ),
  AlignmentModel(
    name: 'Center Right',
    value: Alignment.centerRight,
  ),
  AlignmentModel(
    name: 'Top Center',
    value: Alignment.topCenter,
  ),
  AlignmentModel(
    name: 'Top Left',
    value: Alignment.topLeft,
  ),
  AlignmentModel(
    name: 'Top Right',
    value: Alignment.topRight,
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomPopupMenuSample(),
    ),
  );
}

/// Sample demonstrating `CustomPopupMenuSample`.
class CustomPopupMenuSample extends StatefulWidget {
  /// Creates a [CustomPopupMenuSample].
  const CustomPopupMenuSample({super.key});

  @override
  State<CustomPopupMenuSample> createState() => CustomPopupMenuSampleState();
}

/// Sample demonstrating `CustomPopupMenuSampleState`.
class CustomPopupMenuSampleState extends State<CustomPopupMenuSample> {
  final GlobalKey<State<StatefulWidget>> _buttonKey = GlobalKey();

  OverlayEntry? _overlayEntry;
  Alignment _buttonAlignment = Alignment.center;

  void _showMenu() {
    final rendexBox =
        _buttonKey.currentContext!.findRenderObject()! as RenderBox;
    final buttonPosition = rendexBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.sizeOf(context);
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final buttonSize = rendexBox.size;
    final isButtonAtHorizontalScreenEdge =
        buttonPosition.dx + buttonSize.width == screenWidth;
    final isButtonAtVerticalScreenEdge =
        buttonPosition.dy + buttonSize.height + 120 >= screenHeight;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: <Widget>[
          GestureDetector(
            onTap: _removeOverlay,
            child: Container(
              color: Colors.transparent,
              constraints: const BoxConstraints.expand(),
            ),
          ),
          Positioned(
            top: isButtonAtVerticalScreenEdge
                ? null
                : buttonPosition.dy + buttonSize.height + 4.0,
            right: isButtonAtHorizontalScreenEdge ? 0.0 : null,
            bottom: isButtonAtVerticalScreenEdge
                ? screenHeight - buttonPosition.dy + 4.0
                : null,
            left: isButtonAtHorizontalScreenEdge ? null : buttonPosition.dx,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text('Menu'),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(
      _overlayEntry!,
    );
  }

  void _removeOverlay() {
    if (_overlayEntry?.mounted ?? false) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        _removeOverlay();
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: _buttonAlignment,
                child: ElevatedButton(
                  key: _buttonKey,
                  onPressed: _showMenu,
                  child: const Text('Open'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _buttonAlignment,
                  items: List.generate(alignments.length, (index) {
                    final alignment = alignments[index];

                    return DropdownMenuItem(
                      value: alignment.value,
                      child: Text(
                        alignment.name,
                      ),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      _buttonAlignment = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
