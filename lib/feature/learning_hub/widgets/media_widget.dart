import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaWidget extends StatefulWidget {
  final String url;
  final double height;
  final double? width;
  final double borderRadius;

  const MediaWidget({
    Key? key,
    required this.url,
    this.height = 150,
    this.width,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  VideoPlayerController? _controller;

  bool get _isVideo {
    final lower = widget.url.toLowerCase();
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
          setState(() {}); // refresh after init
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: _isVideo
              ? (_controller != null && _controller!.value.isInitialized)
                  ? Stack(
                      children: [
                        SizedBox(
                          height: widget.height,
                          child: VideoPlayer(_controller!),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: Icon(
                                _controller!.value.isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                size: 48,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller!.value.isPlaying
                                      ? _controller!.pause()
                                      : _controller!.play();
                                });
                              },
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
                  loadingBuilder: (context, child, progress) =>
                      progress == null ? child : const Center(child: CircularProgressIndicator()),
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, color: Colors.red),
                  ),
                ),
        ),
      ],
    );
  }
}
