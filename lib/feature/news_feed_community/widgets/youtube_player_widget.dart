import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late String videoId;
  bool isPlaying = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isPlaying) {
      return YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          isPlaying = true;
        });
        _controller.play();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://img.youtube.com/vi/$videoId/0.jpg",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          /// Dark overlay
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          /// Play Button
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(16),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
