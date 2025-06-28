import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

const _color = Colors.blue;
const _leftDotColor = _color;
const _rightDotColor = Colors.red;
const _size = 32.0;

final _loaders = <Widget>[
  LoadingAnimationWidget.bouncingBall(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.discreteCircle(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.dotsTriangle(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.fallingDot(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.flickr(
    leftDotColor: _leftDotColor,
    rightDotColor: _rightDotColor,
    size: _size,
  ),
  LoadingAnimationWidget.fourRotatingDots(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.halfTriangleDot(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.hexagonDots(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.horizontalRotatingDots(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.inkDrop(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.newtonCradle(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.prograssiveDots(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.staggeredDotsWave(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.stretchedDots(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.threeArchedCircle(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.threeRotatingDots(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.twistingDots(
    leftDotColor: _leftDotColor,
    rightDotColor: _rightDotColor,
    size: _size,
  ),
  LoadingAnimationWidget.twoRotatingArc(
    color: _color,
    size: _size,
  ),
  LoadingAnimationWidget.waveDots(
    color: _color,
    size: _size,
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingAnimationWidgetSample(),
    ),
  );
}

class LoadingAnimationWidgetSample extends StatelessWidget {
  const LoadingAnimationWidgetSample({super.key});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = (MediaQuery.sizeOf(context).width / 100).floor();

    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          itemCount: _loaders.length,
          itemBuilder: (context, index) {
            return Center(
              child: _loaders[index],
            );
          },
        ),
      ),
    );
  }
}
