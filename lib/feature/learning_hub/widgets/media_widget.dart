import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaWidget extends StatefulWidget {
  final String url;
  final String? name;
  final double height;
  final double? width;
  final double borderRadius;

  const MediaWidget({
    Key? key,
    required this.url,
    this.height = 150,
    this.width = 300,
    this.borderRadius = 12,
    required this.name,
  }) : super(key: key);

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  bool get _isVideo {
    final lower = widget.name ?? "";
    return lower.endsWith(".mp4") ||
        lower.endsWith(".mov") ||
        lower.endsWith(".avi") ||
        lower.endsWith(".mkv");
  }

  @override
  void initState() {
    super.initState();
    if (_isVideo) {
      _controller = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          setState(() {}); // refresh UI
        });
    }
  }

  void _togglePlayPause() {
    if (_controller == null) return;
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        _isPlaying = false;
      } else {
        _controller!.play();
        _controller!.setLooping(true);
        _controller!.setVolume(1.0);
        _isPlaying = true;
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: _isVideo
            ? (_controller != null && _controller!.value.isInitialized)
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: widget.height,
                        width: widget.width ?? MediaQuery.of(context).size.width,
                        child: VideoPlayer(_controller!),
                      ),
                      // Play/Pause button overlay
                      GestureDetector(
                        onTap: _togglePlayPause,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            _controller!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    height: widget.height,
                    width: widget.width,
                    color: Colors.black12,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
            : Image.network(
                widget.url,
                height: widget.height,
                width: widget.width,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : const Center(child: CircularProgressIndicator()),
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, color: Colors.red),
                ),
              ),
      ),
    );
  }
}
