import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/constants/image_const.dart';

class LocationViewWidget extends StatelessWidget {
  final String? location;
  final double height;
  final String mapImage;

  const LocationViewWidget({
    Key? key,
    required this.location,
    this.height = 180,
    this.mapImage = ImageConst.mapsPng, // default static map image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Map View",
          style: TextStyles.bold2(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 4),
        Text(
          location??"",
          style: TextStyles.medium2(color: AppColors.black),
        ),
        GestureDetector(
          onTap: () => _openLocationInMaps(context),
          child: Container(
            height: height,
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: AppColors.geryColor,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                mapImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openLocationInMaps(BuildContext context) async {
    if (location == null || location!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Location not available',
            style: TextStyles.regular1(color: AppColors.whiteColor),
          ),
          backgroundColor: AppColors.redColor,
        ),
      );
      return;
    }

    final String encodedLocation = Uri.encodeComponent(location!);
    final String googleMapsApp = 'google.navigation:q=$encodedLocation';
    final String googleMapsWeb =
        'https://www.google.com/maps/search/?api=1&query=$encodedLocation';

    try {
      final Uri appUri = Uri.parse(googleMapsApp);
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri, mode: LaunchMode.externalApplication);
        return;
      }
    } catch (_) {}

    try {
      final Uri webUri = Uri.parse(googleMapsWeb);
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not open maps application',
            style: TextStyles.regular1(color: AppColors.whiteColor),
          ),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }
}
