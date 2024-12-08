import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerSample extends StatefulWidget {
  const VideoPlayerSample({super.key});

  @override
  State<VideoPlayerSample> createState() => _VideoPlayerSampleState();
}

class _VideoPlayerSampleState extends State<VideoPlayerSample> {
  bool _isLoading = true;
  late VideoPlayerController _controller;
  bool _isNetworkUrl = true;

  Future<void> _initializeVideoPlayer() async {
    setState(() {
      _isLoading = true;
    });

    _controller = _isNetworkUrl
        ? VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            ),
          )
        : VideoPlayerController.asset(
            'assets/videos/bee.mp4',
          );

    await _controller.initialize();

    _controller.addListener(_setListeners);

    setState(() {
      _isLoading = false;
    });
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
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Video Origin: ${_isNetworkUrl ? 'Network' : 'Asset'}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12.0),
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
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: () {
                      _isNetworkUrl = !_isNetworkUrl;

                      _initializeVideoPlayer();
                    },
                    child: Text(
                      _isNetworkUrl ? 'Asset Video' : 'Network Video',
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
