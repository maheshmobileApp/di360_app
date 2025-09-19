import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class SponsorsImageWidget extends StatelessWidget {
  final List<String> imagePaths; // Required list of image paths (Asset or Network)
  final double imageHeight;
  final double imageWidth;

  const SponsorsImageWidget({
    Key? key,
    required this.imagePaths,
    this.imageHeight = 10,
    this.imageWidth = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Text(
            "SPONSORS",
            style:  TextStyles.medium2(color: AppColors.primaryColor),
          ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: imagePaths.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (context, index) {
            final path = imagePaths[index];
            return ImageWidget(path: path, height: imageHeight, width: imageWidth);
          },
        ),
      ],
    );
  }
}

/// Helper widget to handle both asset and network images
class ImageWidget extends StatelessWidget {
  final String path;
  final double height;
  final double width;

  const ImageWidget({
    Key? key,
    required this.path,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return path.startsWith("http")
        ? Image.network(path, height: height, width: width, fit: BoxFit.contain)
        : Image.asset(path, height: height, width: width, fit: BoxFit.contain);
  }
}
