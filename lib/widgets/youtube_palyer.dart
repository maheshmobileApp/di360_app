import 'package:flutter/material.dart';
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
  late YoutubePlayerController _controller;
  late String _videoId;

  @override
  void initState() {
    super.initState();
    _videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadPlayer() {
    setState(() => _isPlayerVisible = true);
  }

  @override
  Widget build(BuildContext context) {
    return _isPlayerVisible
        ? YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          )
        : GestureDetector(
            onTap: _loadPlayer,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // YouTube thumbnail
                Image.network(
                  'https://img.youtube.com/vi/$_videoId/0.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                // Play icon
                const Icon(Icons.play_circle_fill,
                    size: 64, color: Colors.white),
              ],
            ),
          );
  }
}
