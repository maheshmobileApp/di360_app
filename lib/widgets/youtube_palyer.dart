import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LazyYoutubePlayer extends StatefulWidget {
  final String youtubeUrl;

  const LazyYoutubePlayer({Key? key, required this.youtubeUrl})
      : super(key: key);

  @override
  State<LazyYoutubePlayer> createState() => _LazyYoutubePlayerState();
}

class _LazyYoutubePlayerState extends State<LazyYoutubePlayer> {
  bool _isPlayerVisible = false;
  YoutubePlayerController? _controller;
  late String _videoId;

  @override
  void initState() {
    super.initState();
    _initController(widget.youtubeUrl);
  }

  @override
  void didUpdateWidget(LazyYoutubePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.youtubeUrl != widget.youtubeUrl) {
      _controller?.removeListener(_playerListener);
      _controller?.dispose();
      _controller = null;
      setState(() {
        _isPlayerVisible = false;
        _initController(widget.youtubeUrl);
      });
    }
  }

  void _initController(String url) {
    _videoId = YoutubePlayer.convertUrlToId(url) ?? '';
    if (_videoId.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: _videoId,
        flags: const YoutubePlayerFlags(autoPlay: true),
      )..addListener(_playerListener);
    }
  }

  void _playerListener() {
    if (_controller?.value.playerState == PlayerState.ended) {
      _controller?.pause();
    }
    _fullScreenListener();
  }

  void _fullScreenListener() {
    if (_controller?.value.isFullScreen == true) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }

  @override
  void dispose() {
    if (_videoId.isNotEmpty && _controller != null) {
      _controller!.removeListener(_playerListener);
      _controller!.dispose();
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void _loadPlayer() {
    setState(() => _isPlayerVisible = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_videoId.isEmpty || widget.youtubeUrl.isEmpty) {
      return Container(
        width: double.infinity,
        height: 200,
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.error, size: 48, color: Colors.grey),
        ),
      );
    }

    return _isPlayerVisible && _controller != null
        ? YoutubePlayer(
            controller: _controller!,
            showVideoProgressIndicator: true,
          )
        : Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[300],
            child: GestureDetector(
              onTap: _loadPlayer,
              child: const Center(
                child: Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
              ),
            ),
          );
  }
}
