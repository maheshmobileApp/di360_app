import 'package:cached_network_image/cached_network_image.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final Widget? errorWidget;
  const CachedNetworkImageWidget(
      {super.key, required this.imageUrl, this.errorWidget});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(
        value: downloadProgress.progress,
        color: AppColors.primaryColor,
      )),
      errorWidget: (context, url, error) {
        return errorWidget ?? Icon(Icons.error);
      },
    );
  }
}
