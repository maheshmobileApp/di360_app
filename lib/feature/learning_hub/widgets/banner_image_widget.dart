import 'package:cached_network_image/cached_network_image.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BannerImageWidget extends StatelessWidget {
  final String imageUrl;

  const BannerImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 180,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.broken_image,
        size: 50,
        color: Colors.red,
      ),
    );
  }
}
