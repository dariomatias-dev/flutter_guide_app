import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class _Candidate {
  const _Candidate({
    required this.name,
    required this.role,
    required this.color,
  });

  /// The [name].
  final String name;

  /// The [role].
  final String role;

  /// The [color].
  final Color color;
}

const _candidates = [
  _Candidate(name: 'Alex Rivera', role: 'Product Designer', color: Colors.blue),
  _Candidate(name: 'Jordan Lee', role: 'Backend Engineer', color: Colors.teal),
  _Candidate(
    name: 'Sam Carter',
    role: 'Marketing Lead',
    color: Colors.orange,
  ),
  _Candidate(name: 'Priya Nair', role: 'UX Researcher', color: Colors.purple),
  _Candidate(
    name: 'Diego Santos',
    role: 'Mobile Developer',
    color: Colors.green,
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterCardSwiperSample(),
    ),
  );
}

/// Sample demonstrating `FlutterCardSwiperSample`.
class FlutterCardSwiperSample extends StatefulWidget {
  /// Creates a [FlutterCardSwiperSample].
  const FlutterCardSwiperSample({super.key});

  @override
  State<FlutterCardSwiperSample> createState() =>
      _FlutterCardSwiperSampleState();
}

class _FlutterCardSwiperSampleState extends State<FlutterCardSwiperSample> {
  final _controller = CardSwiperController();

  int _accepted = 0;
  int _rejected = 0;
  bool _finished = false;
  int _deckKey = 0;

  void _reset() {
    setState(() {
      _accepted = 0;
      _rejected = 0;
      _finished = false;
      _deckKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review candidates',
                    style: theme.textTheme.titleLarge,
                  ),
                  IconButton(
                    tooltip: 'Reset',
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close, color: theme.colorScheme.error, size: 18),
                  const SizedBox(width: 4),
                  Text('$_rejected passed'),
                  const SizedBox(width: 24),
                  const Icon(Icons.favorite, color: Colors.green, size: 18),
                  const SizedBox(width: 4),
                  Text('$_accepted shortlisted'),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _finished
                    ? const Center(
                        child: Text('No more candidates to review.'),
                      )
                    : CardSwiper(
                        key: ValueKey(_deckKey),
                        controller: _controller,
                        cardsCount: _candidates.length,
                        isLoop: false,
                        onEnd: () => setState(() => _finished = true),
                        onSwipe: (previousIndex, currentIndex, direction) {
                          setState(() {
                            if (direction == CardSwiperDirection.right) {
                              _accepted++;
                            } else if (direction == CardSwiperDirection.left) {
                              _rejected++;
                            }
                          });
                          return true;
                        },
                        cardBuilder: (
                          context,
                          index,
                          horizontalOffset,
                          verticalOffset,
                        ) {
                          final candidate = _candidates[index];
                          return _CandidateCard(candidate: candidate);
                        },
                      ),
              ),
              const SizedBox(height: 24),
              if (!_finished)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: 'pass',
                      backgroundColor: theme.colorScheme.error,
                      onPressed: () =>
                          _controller.swipe(CardSwiperDirection.left),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                    const SizedBox(width: 32),
                    FloatingActionButton(
                      heroTag: 'like',
                      backgroundColor: Colors.green,
                      onPressed: () =>
                          _controller.swipe(CardSwiperDirection.right),
                      child: const Icon(Icons.favorite, color: Colors.white),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CandidateCard extends StatelessWidget {
  const _CandidateCard({required this.candidate});

  /// The [candidate].
  final _Candidate candidate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              candidate.color.withValues(alpha: 0.85),
              candidate.color.withValues(alpha: 0.5),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white,
                child: Text(
                  candidate.name[0],
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: candidate.color,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                candidate.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                candidate.role,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
