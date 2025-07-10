import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/news_feed/view/images_full_view.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';


class GalleryView extends StatelessWidget {
  final List<String> imageUrls;
  final List<PostImage> mediaList;
  final double imageSize;
  final Axis direction;
  final EdgeInsetsGeometry spacing;

  const GalleryView({
    super.key,
    required this.imageUrls,
    this.imageSize = 50,
    required this.mediaList,
    this.direction = Axis.horizontal,
    this.spacing = const EdgeInsets.all(4),
  });

  void _openImageGallery(BuildContext context, int initialIndex) {

    navigationService.push(
      ImageViewerScreen(
        initialIndex: initialIndex,
        postImage: mediaList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: direction,
      spacing: spacing.horizontal / 2,
      runSpacing: spacing.vertical / 2,
      children: imageUrls.asMap().entries.map((entry) {
        final index = entry.key;
        final url = entry.value;

        return Hero(
          tag: 'gallery_image_$index',
          child: GestureDetector(
            onTap: () => _openImageGallery(context, index),
            child: Container(
              width: imageSize,
              height: imageSize,
              margin: spacing,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImageWidget(imageUrl: url),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
