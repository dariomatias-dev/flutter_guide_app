import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const _loaders = <Widget>[
  SpinKitRotatingPlain(
    color: Colors.blue,
  ),
  SpinKitDoubleBounce(
    color: Colors.blue,
  ),
  SpinKitWave(
    color: Colors.blue,
  ),
  SpinKitWanderingCubes(
    color: Colors.blue,
  ),
  SpinKitFadingFour(
    color: Colors.blue,
  ),
  SpinKitFadingCube(
    color: Colors.blue,
  ),
  SpinKitPulse(
    color: Colors.blue,
  ),
  SpinKitChasingDots(
    color: Colors.blue,
  ),
  SpinKitThreeBounce(
    color: Colors.blue,
  ),
  SpinKitCircle(
    color: Colors.blue,
  ),
  SpinKitCubeGrid(
    color: Colors.blue,
  ),
  SpinKitFadingCircle(
    color: Colors.blue,
  ),
  SpinKitRotatingCircle(
    color: Colors.blue,
  ),
  SpinKitFoldingCube(
    color: Colors.blue,
  ),
  SpinKitPumpingHeart(
    color: Colors.blue,
  ),
  SpinKitHourGlass(
    color: Colors.blue,
  ),
  SpinKitPouringHourGlass(
    color: Colors.blue,
  ),
  SpinKitPouringHourGlassRefined(
    color: Colors.blue,
  ),
  SpinKitFadingGrid(
    color: Colors.blue,
  ),
  SpinKitRing(
    color: Colors.blue,
  ),
  SpinKitRipple(
    color: Colors.blue,
  ),
  SpinKitSpinningCircle(
    color: Colors.blue,
  ),
  SpinKitSpinningLines(
    color: Colors.blue,
  ),
  SpinKitSquareCircle(
    color: Colors.blue,
  ),
  SpinKitDualRing(
    color: Colors.blue,
  ),
  SpinKitPianoWave(
    color: Colors.blue,
  ),
  SpinKitDancingSquare(
    color: Colors.blue,
  ),
  SpinKitThreeInOut(
    color: Colors.blue,
  ),
  SpinKitWaveSpinner(
    color: Colors.blue,
  ),
  SpinKitPulsingGrid(
    color: Colors.blue,
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSpinkitSample(),
    ),
  );
}

class FlutterSpinkitSample extends StatelessWidget {
  const FlutterSpinkitSample({super.key});

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
            return _loaders[index];
          },
        ),
      ),
    );
  }
}
