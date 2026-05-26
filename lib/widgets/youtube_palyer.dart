import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

enum _VideoType { youtube, webview, unknown }

Future<String?> _fetchWebviewThumbnail(String url) async {
  try {
    if (url.contains('vimeo.com')) {
      final id = Uri.parse(url).pathSegments.firstWhere((s) => s.isNotEmpty, orElse: () => '');
      final res = await http.get(Uri.parse('https://vimeo.com/api/v2/video/$id.json'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data[0]['thumbnail_large'] as String?;
      }
    }
    if (url.contains('loom.com')) {
      final res = await http.get(Uri.parse('https://www.loom.com/v1/oembed?url=${Uri.encodeComponent(url)}'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['thumbnail_url'] as String?;
      }
    }
  } catch (_) {}
  return null;
}

_VideoType _detectType(String url) {
  if (url.isEmpty) return _VideoType.unknown;
  if (url.contains('youtube.com') || url.contains('youtu.be')) return _VideoType.youtube;
  if (url.contains('drive.google.com') || url.contains('loom.com') || url.contains('vimeo.com')) {
    return _VideoType.webview;
  }
  return _VideoType.unknown;
}

String _toEmbedUrl(String url) {
  if (url.contains('loom.com/share/')) return url.replaceFirst('/share/', '/embed/');
  if (url.contains('vimeo.com')) {
    final id = Uri.parse(url).pathSegments.firstWhere((s) => s.isNotEmpty, orElse: () => '');
    return 'https://player.vimeo.com/video/$id?autoplay=1&muted=0';
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

// ─── Main Widget ─────────────────────────────────────────────────────────────

class LazyYoutubePlayer extends StatefulWidget {
  final String youtubeUrl;
  final String? thumbnailUrl;

  const LazyYoutubePlayer({Key? key, required this.youtubeUrl, this.thumbnailUrl}) : super(key: key);

  @override
  State<LazyYoutubePlayer> createState() => _LazyYoutubePlayerState();
}

class _LazyYoutubePlayerState extends State<LazyYoutubePlayer> {
  YoutubePlayerController? _ytController;
  InAppWebViewController? _webViewController;
  String _videoId = '';
  _VideoType _type = _VideoType.unknown;
  String _embedUrl = '';
  bool _playing = false;
  bool _thumbnailDismissed = false;
  String? _fetchedThumbnail;

  @override
  void initState() {
    super.initState();
    _init(widget.youtubeUrl);
  }

  @override
  void didUpdateWidget(LazyYoutubePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.youtubeUrl != widget.youtubeUrl) {
      // stop current playback immediately
      _ytController?.pause();
      _ytController?.dispose();
      _ytController = null;
      _webViewController?.evaluateJavascript(
        source: "(function(){ var v=document.querySelector('video'); if(v){v.pause();v.src='';} })();",
      );
      _webViewController = null;
      // reset all state and load new url
      setState(() {
        _playing = false;
        _thumbnailDismissed = false;
        _fetchedThumbnail = null;
        _init(widget.youtubeUrl);
      });
    }
  }

  void _init(String url) {
    _type = _detectType(url);
    _embedUrl = _toEmbedUrl(url);
    _videoId = _type == _VideoType.youtube ? (YoutubePlayer.convertUrlToId(url) ?? '') : '';
    if (_type == _VideoType.webview) {
      _playing = true;
      _fetchWebviewThumbnail(url).then((thumb) {
        if (mounted && thumb != null) setState(() => _fetchedThumbnail = thumb);
      });
    }
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
      setState(() => _playing = true);
      return;
    }
    setState(() => _thumbnailDismissed = true);
    _triggerWebviewPlay();
    Future.delayed(const Duration(milliseconds: 500), _triggerWebviewPlay);
  }

  void _triggerWebviewPlay() {
    _webViewController?.evaluateJavascript(source: """
      (function() {
        var v = document.querySelector('video');
        if (v) { v.play(); return; }
        var btn = document.querySelector('[aria-label="Play"], .play-button, button[title="Play"]');
        if (btn) btn.click();
      })();
    """);
  }

  void _enterFullscreen() {
    final position = _ytController?.value.position ?? Duration.zero;
    // pause inline before going fullscreen
    _ytController?.pause();
    _webViewController?.evaluateJavascript(
      source: "(function(){ var v=document.querySelector('video'); if(v) v.pause(); })();",
    );

    Navigator.of(context).push(_FullscreenRoute(
      embedUrl: _embedUrl,
      type: _type,
      ytController: _ytController,
      webViewController: _webViewController,
      startPosition: position,
    )).then((_) {
      if (!mounted) return;
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      // resume inline from where fullscreen left off
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        _ytController?.play();
        _triggerWebviewPlay();
      });
    });
  }

  @override
  void dispose() {
    _ytController?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Widget _buildYoutubePlayer() {
    if (_ytController == null) return const SizedBox.shrink();
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
        IconButton(
          icon: const Icon(Icons.fullscreen, color: Colors.white),
          onPressed: _enterFullscreen,
        ),
      ],
    );
  }

  Widget _placeholder() {
    String? thumb;
    if (_type == _VideoType.youtube && _videoId.isNotEmpty) {
      thumb = 'https://img.youtube.com/vi/$_videoId/hqdefault.jpg';
    } else {
      thumb = widget.thumbnailUrl ?? _fetchedThumbnail;
    }

    return GestureDetector(
      onTap: _onPlay,
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            thumb != null
                ? Image.network(
                    thumb,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(width: double.infinity, height: 200, color: Colors.grey[300]),
                  )
                : Container(width: double.infinity, height: 200, color: Colors.grey[850]),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
              child: const Icon(Icons.play_arrow, size: 40, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_type == _VideoType.unknown) {
      return Container(
        height: 200,
        color: Colors.grey[300],
        child: const Center(child: Icon(Icons.error, size: 48, color: Colors.grey)),
      );
    }

    if (_type == _VideoType.youtube) {
      if (!_playing) return _placeholder();
      return _buildYoutubePlayer();
    }

    // webview: ValueKey forces full rebuild when URL changes
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Stack(
        children: [
          InAppWebView(
            key: ValueKey(_embedUrl),
            initialUrlRequest: URLRequest(url: WebUri(_embedUrl)),
            initialSettings: InAppWebViewSettings(
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              javaScriptEnabled: true,
            ),
            onWebViewCreated: (c) => _webViewController = c,
            onLoadStop: (c, _) {
              if (_thumbnailDismissed || _embedUrl.contains('loom.com') || _embedUrl.contains('drive.google.com')) _triggerWebviewPlay();
            },
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: _enterFullscreen,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.fullscreen, color: Colors.white, size: 22),
              ),
            ),
          ),
          if (!_thumbnailDismissed && !_embedUrl.contains('loom.com') && !_embedUrl.contains('drive.google.com')) _placeholder(),
        ],
      ),
    );
  }
}
class _FullscreenRoute extends PageRoute<void> {
  final String embedUrl;
  final _VideoType type;
  final YoutubePlayerController? ytController;
  final InAppWebViewController? webViewController;
  final Duration startPosition;

  _FullscreenRoute({
    required this.embedUrl,
    required this.type,
    this.ytController,
    this.webViewController,
    this.startPosition = Duration.zero,
  });

  @override Color get barrierColor => Colors.black;
  @override bool get barrierDismissible => false;
  @override String? get barrierLabel => null;
  @override bool get maintainState => true;
  @override Duration get transitionDuration => Duration.zero;

  @override
  Widget buildPage(BuildContext context, Animation<double> a, Animation<double> sa) {
    return _FullscreenPage(
      embedUrl: embedUrl,
      type: type,
      ytController: ytController,
      webViewController: webViewController,
      startPosition: startPosition,
    );
  }
}

class _FullscreenPage extends StatefulWidget {
  final String embedUrl;
  final _VideoType type;
  final YoutubePlayerController? ytController;
  final InAppWebViewController? webViewController;
  final Duration startPosition;

  const _FullscreenPage({
    required this.embedUrl,
    required this.type,
    this.ytController,
    this.webViewController,
    this.startPosition = Duration.zero,
  });

  @override
  State<_FullscreenPage> createState() => _FullscreenPageState();
}

class _FullscreenPageState extends State<_FullscreenPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // seek to saved position and play after orientation settles
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      if (widget.ytController != null) {
        widget.ytController!.seekTo(widget.startPosition);
        widget.ytController!.play();
      }
      widget.webViewController?.evaluateJavascript(
        source: "(function(){ var v=document.querySelector('video'); if(v) v.play(); })();",
      );
    });
  }

  void _exit() {
    // pause fullscreen before popping so inline resumes cleanly
    widget.ytController?.pause();
    widget.webViewController?.evaluateJavascript(
      source: "(function(){ var v=document.querySelector('video'); if(v) v.pause(); })();",
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (widget.type == _VideoType.youtube && widget.ytController != null)
            Center(
              child: YoutubePlayer(
                controller: widget.ytController!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.red,
                  handleColor: Colors.redAccent,
                ),
                onEnded: (_) => widget.ytController?.pause(),
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                  RemainingDuration(),
                ],
              ),
            )
          else
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.embedUrl)),
              initialSettings: InAppWebViewSettings(
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
                javaScriptEnabled: true,
              ),
              onLoadStop: (c, _) {
                c.evaluateJavascript(
                  source: "(function(){ var v=document.querySelector('video'); if(v) v.play(); })();",
                );
              },
            ),
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              child: GestureDetector(
                onTap: _exit,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.fullscreen_exit, color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
