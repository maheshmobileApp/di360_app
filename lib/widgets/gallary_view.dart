import 'package:flutter/material.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/image_gallery_popup.dart';

class GalleryView extends StatelessWidget {
  final List<String> imageUrls;
  final double imageSize;
  final Axis direction;
  final EdgeInsetsGeometry spacing;

  const GalleryView({
    super.key,
    required this.imageUrls,
    this.imageSize = 50,
    this.direction = Axis.horizontal,
    this.spacing = const EdgeInsets.all(4),
  });

  void _openImageGallery(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ImageGalleryPopup(
          imageUrls: imageUrls,
          initialIndex: initialIndex,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
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
