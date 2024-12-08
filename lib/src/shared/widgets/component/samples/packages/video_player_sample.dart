import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerSample extends StatefulWidget {
  const VideoPlayerSample({super.key});

  @override
  State<VideoPlayerSample> createState() => _VideoPlayerSampleState();
}

class _VideoPlayerSampleState extends State<VideoPlayerSample> {
  late VideoPlayerController _controller;

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );

    await _controller.initialize();

    _controller.addListener(_setListeners);

    setState(() {});
  }

  void _setListeners() {
    if (_controller.value.isCompleted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _initializeVideoPlayer();

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_setListeners);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  const SizedBox(height: 20.0),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
