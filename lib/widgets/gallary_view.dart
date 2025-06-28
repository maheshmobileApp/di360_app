import 'package:flutter/material.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: direction,
      spacing: spacing.horizontal / 2,
      runSpacing: spacing.vertical / 2,
      children: imageUrls.map((url) {
        return Container(
          width: imageSize,
          height: imageSize,
          margin: spacing,
          child: CachedNetworkImageWidget(imageUrl: url),
        );
      }).toList(),
    );
  }
}
