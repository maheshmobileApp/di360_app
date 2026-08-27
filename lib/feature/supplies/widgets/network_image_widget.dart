import 'package:cached_network_image/cached_network_image.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  const NetworkImageWidget(
      {super.key,
      required this.imageUrl,
      this.fit,
      this.height,
      this.width,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        fit: fit ?? BoxFit.fill,
        imageUrl: imageUrl,
        height: height,
        width: width,
        placeholder: (context, url) => const Center(
            child:  CupertinoActivityIndicator.partiallyRevealed(
                color: AppColors.primaryColor)),
        errorWidget: (context, url, error) => const SizedBox(),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.fill,
            ),
          ),
        )
      ),
    );
  }
}
