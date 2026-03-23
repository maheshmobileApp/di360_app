import 'package:di360_flutter/feature/news_feed/view/inline_video_play.dart';
import 'package:di360_flutter/feature/support/model/get_support_messages_res.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class MediaAttachmentsWidget extends StatelessWidget {
  final List<Attachments>? mediaList;
  final Function(List<Attachments>)? onTap;

  const MediaAttachmentsWidget({
    super.key,
    required this.mediaList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final list = mediaList ?? [];

    if (list.isEmpty) return const SizedBox();

    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: list.length == 1
          ? _buildSingleMedia(context, list)
          : _buildMultipleMedia(context, list),
    );
  }

  /// ---------------- SINGLE MEDIA ----------------
  Widget _buildSingleMedia(BuildContext context, List<Attachments> list) {
    final media = list.first;

    return GestureDetector(
      onTap: () => onTap?.call(list),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _buildMediaWidget(media, isFullSize: true),
        ),
      ),
    );
  }

  /// ---------------- MULTIPLE MEDIA ----------------
  Widget _buildMultipleMedia(BuildContext context, List<Attachments> list) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final media = list[index];

          return GestureDetector(
            onTap: () => onTap?.call(list),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildMediaWidget(media),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ---------------- MEDIA HANDLER ----------------
  Widget _buildMediaWidget(Attachments media, {bool isFullSize = false}) {
    final type = media.type ?? '';
    final url = media.url ?? '';
    final name = media.name ?? '';

    /// -------- VIDEO --------
    if (type.contains('video') || name.endsWith('.mp4')) {
      return Stack(
        fit: StackFit.expand,
        children: [
          InlineVideoPlayer(videoUrl: url),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child:
                  const Icon(Icons.play_arrow, color: Colors.white, size: 16),
            ),
          ),
        ],
      );
    }

    /// -------- PDF --------
    if (type.contains('pdf') || name.endsWith('.pdf')) {
      return _fileContainer(
        color: Colors.red[50]!,
        icon: Icons.picture_as_pdf,
        iconColor: Colors.red,
        title: name,
        isFullSize: isFullSize,
      );
    }

    /// -------- WORD --------
    if (type.contains('msword') ||
        name.endsWith('.doc') ||
        name.endsWith('.docx')) {
      return _fileContainer(
        color: Colors.blue[50]!,
        icon: Icons.description,
        iconColor: Colors.blue,
        title: name,
        isFullSize: isFullSize,
      );
    }

    /// -------- IMAGE --------
    return CachedNetworkImageWidget(
      imageUrl: url,
      fit: BoxFit.contain,
      errorWidget: Container(
        color: Colors.grey[200],
        child: Icon(Icons.broken_image, color: Colors.grey[400]),
      ),
    );
  }

  /// ---------------- COMMON FILE UI ----------------
  Widget _fileContainer({
    required Color color,
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool isFullSize,
  }) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: isFullSize ? 50 : 40, color: iconColor),
          const SizedBox(height: 8),
          if (isFullSize)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title.isNotEmpty ? title : 'Document',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}
