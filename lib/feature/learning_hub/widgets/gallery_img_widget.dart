import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class GalleryImgWidget extends StatelessWidget {
  final List<String> imageUrls;
  final double height;
  final double borderRadius;
  final double spacing;
  final String? title;
  final double? width;

  const GalleryImgWidget({
    Key? key,
    required this.imageUrls,
    this.height = 150,
    this.borderRadius = 12,
    this.spacing = 8,
    this.title = "",
    this.width = 0, // default title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty) ...[
          Text(
            title!,
            style: TextStyles.bold2(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrls.length,
            separatorBuilder: (_, __) => SizedBox(width: spacing),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: CachedNetworkImageWidget(
                  imageUrl: imageUrls[index],
                  height: height,
                  width: (width == 0) ? height * 1.5 : width,
                  fit: BoxFit.contain,
                  errorWidget: Container(
                    height: height,
                    width: (width == 0) ? height * 1.5 : width,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, color: Colors.red),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
