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
  // Google Search URL with embedded YouTube video ID
  if (url.contains('google.com/search') && url.contains('vid:')) {
    return _VideoType.youtube;
  }
  if (url.contains('drive.google.com') ||
      url.contains('loom.com') ||
      url.contains('vimeo.com')) {
    return _VideoType.webview;
  }
  return _VideoType.unknown;
}

String _toEmbedUrl(String url) {
  if (url.contains('loom.com/share/')) {
    return url.replaceFirst('/share/', '/embed/');
  }
  if (url.contains('vimeo.com')) {
    final uri = Uri.parse(url);
    final id = uri.pathSegments.firstWhere((s) => s.isNotEmpty, orElse: () => '');
    return 'https://player.vimeo.com/video/$id';
  }
  // Google Drive: .../file/d/FILE_ID/view → .../file/d/FILE_ID/preview
  if (url.contains('drive.google.com')) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    final dIndex = segments.indexOf('d');
    if (dIndex != -1 && dIndex + 1 < segments.length) {
      final fileId = segments[dIndex + 1];
      return 'https://drive.google.com/file/d/$fileId/preview';
    }
  }
  return url;
}

/// Extracts YouTube video ID from a Google Search URL containing vid:ID
String? _extractYoutubeIdFromGoogleSearch(String url) {
  final match = RegExp(r'vid:([A-Za-z0-9_-]{11})').firstMatch(url);
  return match?.group(1);
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
      // Try standard YouTube URL first, then Google Search embedded vid
      _videoId = YoutubePlayer.convertUrlToId(url) ??
          _extractYoutubeIdFromGoogleSearch(url) ??
          '';
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
    final thumbnailUrl = _type == _VideoType.youtube && _videoId.isNotEmpty
        ? 'https://img.youtube.com/vi/$_videoId/hqdefault.jpg'
        : null;

    return GestureDetector(
      onTap: () => setState(() => _isPlayerVisible = true),
      child: Stack(
        alignment: Alignment.center,
        children: [
          thumbnailUrl != null
              ? Image.network(
                  thumbnailUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300],
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, size: 40, color: Colors.white),
          ),
        ],
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
