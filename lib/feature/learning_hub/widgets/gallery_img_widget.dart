import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class GalleryImgWidget extends StatelessWidget {
  final List<String> imageUrls;
  final double height;
  final double borderRadius;
  final double spacing;
  final String? title; // optional title

  const GalleryImgWidget({
    Key? key,
    required this.imageUrls,
    this.height = 150,
    this.borderRadius = 12,
    this.spacing = 8,
    this.title = "Gallery", // default title
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
                child: Image.network(
                  imageUrls[index],
                  height: height,
                  width: height * 2.18, // aspect ratio like reference
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: height,
                      width: height * 1.5,
                      color: Colors.grey.shade300,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: height,
                    width: height * 1.5,
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
