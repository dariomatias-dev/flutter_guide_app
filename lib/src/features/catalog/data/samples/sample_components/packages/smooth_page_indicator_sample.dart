import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final _pages = List.generate(10, (index) {
  return Container(
    height: 200.0,
    margin: const EdgeInsets.symmetric(
      horizontal: 10.0,
    ),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Center(
      child: Text(
        'Item ${index + 1}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
});

class _IndicatorEffectModel {
  const _IndicatorEffectModel({
    required this.title,
    required this.effect,
  });

  final String title;
  final IndicatorEffect effect;
}

final _dotColor = Colors.grey.shade300;
final _activeDotColor = Colors.blue.shade400;
const _dotHeight = 12.0;
const _dotWidth = 12.0;

final _smoothPageIndicators = <_IndicatorEffectModel>[
  _IndicatorEffectModel(
    title: 'Worm',
    effect: WormEffect(
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Worm style = WormStyle.thin',
    effect: WormEffect(
      type: WormType.thin,
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Worm style = WormStyle.underground',
    effect: WormEffect(
      type: WormType.thinUnderground,
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Worm style = WormStyle.thinUnderground',
    effect: WormEffect(
      type: WormType.underground,
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Expanding Dots',
    effect: ExpandingDotsEffect(
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Jumping dot',
    effect: JumpingDotEffect(
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Jumping dot with vertical offset',
    effect: JumpingDotEffect(
      verticalOffset: 5.0,
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Scrolling Dots',
    effect: ScrollingDotsEffect(
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Slide',
    effect: SlideEffect(
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Slide style = SlideStyle.slideUnder',
    effect: SlideEffect(
      type: SlideType.slideUnder,
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Scale',
    effect: ScaleEffect(
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Swap',
    effect: SwapEffect(
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Swap type = SwapType.yRotation',
    effect: SwapEffect(
      type: SwapType.yRotation,
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Swap type = SwapType.zRotation',
    effect: SwapEffect(
      type: SwapType.zRotation,
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
  _IndicatorEffectModel(
    title: 'Color Transition',
    effect: ColorTransitionEffect(
      dotColor: _dotColor,
      activeDotColor: _activeDotColor,
      dotHeight: _dotHeight,
      dotWidth: _dotWidth,
    ),
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SmoothPageIndicatorSample(),
    ),
  );
}

class SmoothPageIndicatorSample extends StatefulWidget {
  const SmoothPageIndicatorSample({super.key});

  @override
  State<SmoothPageIndicatorSample> createState() =>
      _SmoothPageIndicatorSampleState();
}

class _SmoothPageIndicatorSampleState extends State<SmoothPageIndicatorSample> {
  final _pageViewController = PageController(
    viewportFraction: 0.8,
    keepPage: true,
  );

  @override
  void dispose() {
    _pageViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: PageView.builder(
                controller: _pageViewController,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _pages[index];
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                ),
                itemCount: _smoothPageIndicators.length,
                itemBuilder: (context, index) {
                  final smoothPageIndicator = _smoothPageIndicators[index];

                  return Column(
                    children: <Widget>[
                      Text(
                        smoothPageIndicator.title,
                      ),
                      const SizedBox(height: 6.0),
                      SmoothPageIndicator(
                        controller: _pageViewController,
                        count: _pages.length,
                        effect: smoothPageIndicator.effect,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
