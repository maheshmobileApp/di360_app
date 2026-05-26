import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

enum _VideoType { youtube, webview, unknown }

_VideoType _detectType(String url) {
  if (url.isEmpty) return _VideoType.unknown;
  if (url.contains('youtube.com') || url.contains('youtu.be'))
    return _VideoType.youtube;
  if (url.contains('drive.google.com') ||
      url.contains('loom.com') ||
      url.contains('vimeo.com')) return _VideoType.webview;
  return _VideoType.unknown;
}

String _toEmbedUrl(String url) {
  if (url.contains('loom.com/share/')) {
    return url.replaceFirst('/share/', '/embed/');
  }
  if (url.contains('vimeo.com')) {
    final id = Uri.parse(url)
        .pathSegments
        .firstWhere((s) => s.isNotEmpty, orElse: () => '');
    return 'https://player.vimeo.com/video/$id?autoplay=1';
  }
  if (url.contains('drive.google.com')) {
    final segments = Uri.parse(url).pathSegments;
    final dIndex = segments.indexOf('d');
    if (dIndex != -1 && dIndex + 1 < segments.length) {
      return 'https://drive.google.com/file/d/${segments[dIndex + 1]}/preview';
    }
  }
  return url;
}

class LazyYoutubePlayer extends StatefulWidget {
  final String youtubeUrl;
  final String? thumbnailUrl;

  const LazyYoutubePlayer(
      {Key? key, required this.youtubeUrl, this.thumbnailUrl})
      : super(key: key);

  @override
  State<LazyYoutubePlayer> createState() => _LazyYoutubePlayerState();
}

class _LazyYoutubePlayerState extends State<LazyYoutubePlayer> {
  YoutubePlayerController? _ytController;
  String _videoId = '';
  _VideoType _type = _VideoType.unknown;
  String _embedUrl = '';
  bool _playing = false;
  bool _isFullscreen = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _init(widget.youtubeUrl);
  }

  @override
  void didUpdateWidget(LazyYoutubePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.youtubeUrl != widget.youtubeUrl) {
      _removeOverlay();
      _ytController?.dispose();
      _ytController = null;
      setState(() {
        _playing = false;
        _isFullscreen = false;
        _init(widget.youtubeUrl);
      });
    }
  }

  void _init(String url) {
    _type = _detectType(url);
    _embedUrl = _toEmbedUrl(url);
    _videoId = _type == _VideoType.youtube
        ? (YoutubePlayer.convertUrlToId(url) ?? '')
        : '';
  }

  void _onPlay() {
    if (_type == _VideoType.youtube && _videoId.isNotEmpty) {
      _ytController = YoutubePlayerController(
        initialVideoId: _videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          useHybridComposition: true,
          controlsVisibleAtStart: true,
        ),
      );
    }
    setState(() => _playing = true);
  }

  void _enterFullscreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() => _isFullscreen = true);
    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: Material(
          color: Colors.black,
          child: SafeArea(
            child: Stack(
              children: [
                _buildActivePlayer(),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.fullscreen_exit,
                        color: Colors.white, size: 28),
                    onPressed: _exitFullscreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _exitFullscreen() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _removeOverlay();
    setState(() => _isFullscreen = false);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    _ytController?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Widget _buildActivePlayer() {
    if (_type == _VideoType.youtube && _ytController != null) {
      return YoutubePlayer(
        controller: _ytController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        onEnded: (_) => _ytController?.pause(),
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          if (!_isFullscreen)
            IconButton(
              icon: const Icon(Icons.fullscreen, color: Colors.white),
              onPressed: _enterFullscreen,
            ),
        ],
      );
    }

    // WebView player for Drive / Loom / Vimeo
    return _WebViewPlayer(
      embedUrl: _embedUrl,
      onFullscreen: _isFullscreen ? null : _enterFullscreen,
    );
  }

  Widget _placeholder() {
    final thumb = _type == _VideoType.youtube && _videoId.isNotEmpty
        ? 'https://img.youtube.com/vi/$_videoId/hqdefault.jpg'
        : widget.thumbnailUrl;

    return GestureDetector(
      onTap: _onPlay,
      child: Stack(
        alignment: Alignment.center,
        children: [
          thumb != null
              ? Image.network(
                  thumb,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300]),
                )
              : Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[850],
                  child: const Icon(Icons.play_circle_outline,
                      size: 64, color: Colors.white54),
                ),
          if (thumb != null)
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.play_arrow, size: 40, color: Colors.white),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_type == _VideoType.unknown) {
      return Container(
        height: 200,
        color: Colors.grey[300],
        child: const Center(
            child: Icon(Icons.error, size: 48, color: Colors.grey)),
      );
    }

    if (!_playing) return _placeholder();
    if (_isFullscreen) return Container(height: 200, color: Colors.black);

    return _buildActivePlayer();
  }
}

class _WebViewPlayer extends StatelessWidget {
  final String embedUrl;
  final VoidCallback? onFullscreen;

  const _WebViewPlayer({required this.embedUrl, this.onFullscreen});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(embedUrl)),
          initialSettings: InAppWebViewSettings(
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              javaScriptEnabled: true),
        ),
        if (onFullscreen != null)
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: onFullscreen,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(6)),
                child:
                    const Icon(Icons.fullscreen, color: Colors.white, size: 22),
              ),
            ),
          ),
      ],
    );
  }
}
