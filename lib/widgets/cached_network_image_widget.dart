import 'package:cached_network_image/cached_network_image.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  final Widget? errorWidget;
  const CachedNetworkImageWidget(
      {super.key, required this.imageUrl, this.errorWidget, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width:width,
      height: height,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CupertinoActivityIndicator(
        // value: downloadProgress.progress,
        color: AppColors.primaryColor,
      )),
      errorWidget: (context, url, error) {
        return errorWidget ?? Icon(Icons.error);
      },
    );
  }
}
