import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

enum _VideoType { youtube, webview, unknown }

_VideoType _detectVideoType(String url) {
  if (url.isEmpty) return _VideoType.unknown;
  if (url.contains('youtube.com') || url.contains('youtu.be')) {
    return _VideoType.youtube;
  }
  if (url.contains('loom.com') || url.contains('vimeo.com')) {
    return _VideoType.webview;
  }
  return _VideoType.unknown;
}

String _toEmbedUrl(String url) {
  // Loom: https://www.loom.com/share/ID → https://www.loom.com/embed/ID
  if (url.contains('loom.com/share/')) {
    return url.replaceFirst('/share/', '/embed/');
  }
  // Vimeo: https://vimeo.com/ID?... → https://player.vimeo.com/video/ID
  if (url.contains('vimeo.com')) {
    final uri = Uri.parse(url);
    final id = uri.pathSegments.firstWhere((s) => s.isNotEmpty, orElse: () => '');
    return 'https://player.vimeo.com/video/$id';
  }
  return url;
}

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
  String _videoId = '';
  _VideoType _type = _VideoType.unknown;
  String _embedUrl = '';

  @override
  void initState() {
    super.initState();
    _init(widget.youtubeUrl);
  }

  @override
  void didUpdateWidget(LazyYoutubePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.youtubeUrl != widget.youtubeUrl) {
      _controller?.removeListener(_playerListener);
      _controller?.dispose();
      _controller = null;
      _isPlayerVisible = false;
      _init(widget.youtubeUrl);
      setState(() {});
    }
  }

  void _init(String url) {
    _type = _detectVideoType(url);
    _embedUrl = _toEmbedUrl(url);
    _videoId = '';
    if (_type == _VideoType.youtube) {
      _videoId = YoutubePlayer.convertUrlToId(url) ?? '';
      if (_videoId.isNotEmpty) {
        _controller = YoutubePlayerController(
          initialVideoId: _videoId,
          flags: const YoutubePlayerFlags(autoPlay: true),
        )..addListener(_playerListener);
      }
    }
  }

  void _playerListener() {
    if (_controller?.value.playerState == PlayerState.ended) {
      _controller?.pause();
    }
    if (_controller?.value.isFullScreen == true) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_playerListener);
    _controller?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Widget _placeholder() {
    return GestureDetector(
      onTap: () => setState(() => _isPlayerVisible = true),
      child: Container(
        width: double.infinity,
        height: 200,
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_type == _VideoType.unknown || widget.youtubeUrl.isEmpty) {
      return Container(
        width: double.infinity,
        height: 200,
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.error, size: 48, color: Colors.grey),
        ),
      );
    }

    if (_type == _VideoType.youtube) {
      if (_videoId.isEmpty) {
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
          : _placeholder();
    }

    // Loom / Vimeo via InAppWebView
    return _isPlayerVisible
        ? SizedBox(
            height: 220,
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(_embedUrl)),
              initialSettings: InAppWebViewSettings(
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
                javaScriptEnabled: true,
              ),
            ),
          )
        : _placeholder();
  }
}
