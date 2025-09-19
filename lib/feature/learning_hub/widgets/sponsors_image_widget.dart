import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class SponsorsImageWidget extends StatelessWidget {
  final List<String> imageUrls;
  final double borderRadius;
  final double spacing;
  final String? title; // optional title

  const SponsorsImageWidget({
    Key? key,
    required this.imageUrls,
    this.borderRadius = 12,
    this.spacing = 10,
    this.title = "Sponsors", // default title
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
        ],
        GridView.builder(
          shrinkWrap: true, // allow inside Column
          physics: const NeverScrollableScrollPhysics(), // avoid scroll conflict
          itemCount: imageUrls.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, color: Colors.red),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
