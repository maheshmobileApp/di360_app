import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeThumbnailPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const YoutubeThumbnailPlayerWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  State<YoutubeThumbnailPlayerWidget> createState() =>
      _YoutubeThumbnailPlayerWidgetState();
}

class _YoutubeThumbnailPlayerWidgetState
    extends State<YoutubeThumbnailPlayerWidget> {
  late YoutubePlayerController _controller;
  late String videoId;

  bool showPlayer = false;

  @override
  void initState() {
    super.initState();

    videoId = YoutubePlayerController.convertUrlToId(widget.videoUrl) ?? '';

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableCaption: true,
        mute: false,
        strictRelatedVideos: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _playVideo() {
    setState(() {
      showPlayer = true;
    });

    _controller.loadVideoById(videoId: videoId);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: showPlayer
          ? AspectRatio(
              aspectRatio: 16 / 9,
              child: YoutubePlayer(
                controller: _controller,
              ),
            )
          : GestureDetector(
              onTap: _playVideo,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// Thumbnail
                  Image.network(
                    "https://img.youtube.com/vi/$videoId/0.jpg",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  /// Dark overlay
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),

                  /// Play button
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
