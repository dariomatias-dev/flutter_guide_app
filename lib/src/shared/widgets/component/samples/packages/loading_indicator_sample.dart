import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

const _indicatorTypes = <Indicator>[
  Indicator.audioEqualizer,
  Indicator.ballBeat,
  Indicator.ballClipRotate,
  Indicator.ballClipRotateMultiple,
  Indicator.ballClipRotatePulse,
  Indicator.ballGridBeat,
  Indicator.ballGridPulse,
  Indicator.ballPulse,
  Indicator.ballPulseRise,
  Indicator.ballPulseSync,
  Indicator.ballRotate,
  Indicator.ballRotateChase,
  Indicator.ballScale,
  Indicator.ballScaleMultiple,
  Indicator.ballScaleRipple,
  Indicator.ballScaleRippleMultiple,
  Indicator.ballTrianglePath,
  Indicator.ballTrianglePathColored,
  Indicator.ballTrianglePathColoredFilled,
  Indicator.ballZigZag,
  Indicator.ballZigZagDeflect,
  Indicator.circleStrokeSpin,
  Indicator.cubeTransition,
  Indicator.lineScale,
  Indicator.lineScaleParty,
  Indicator.lineScalePulseOut,
  Indicator.lineScalePulseOutRapid,
  Indicator.lineSpinFadeLoader,
  Indicator.orbit,
  Indicator.pacman,
  Indicator.semiCircleSpin,
  Indicator.squareSpin,
  Indicator.triangleSkewSpin,
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingIndicatorSample(),
    ),
  );
}

class LoadingIndicatorSample extends StatelessWidget {
  const LoadingIndicatorSample({super.key});

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
          itemCount: _indicatorTypes.length,
          itemBuilder: (context, index) {
            return Center(
              child: SizedBox(
                height: 48.0,
                child: LoadingIndicator(
                  indicatorType: _indicatorTypes[index],
                  colors: const <Color>[
                    Colors.blue,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
