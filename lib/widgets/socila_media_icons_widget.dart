import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocilaMediaIconsWidget extends StatelessWidget {
  final String? facebook;
  final String? instagram;
  final String? youtube;
  final String? linkedin;
  const SocilaMediaIconsWidget(
      {super.key, this.facebook, this.instagram, this.youtube, this.linkedin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (facebook != null && facebook!.isNotEmpty)
          IconButton(
              icon: ImageWidget(imageUrl: ImageConst.facebookSvg),
              onPressed: () async {
                final Uri appUri = Uri.parse(facebook!);
                if (await canLaunchUrl(appUri)) {
                  await launchUrl(appUri, mode: LaunchMode.externalApplication);
                  return;
                }
              }),
        if (youtube != null && youtube!.isNotEmpty)
          IconButton(
              icon: ImageWidget(imageUrl: ImageConst.youtubeSvg),
              onPressed: () async {
                final Uri appUri = Uri.parse(youtube!);
                if (await canLaunchUrl(appUri)) {
                  await launchUrl(appUri, mode: LaunchMode.externalApplication);
                  return;
                }
              }),
        if (instagram != null && instagram!.isNotEmpty)
          IconButton(
              icon: ImageWidget(imageUrl: ImageConst.instagramSvg),
              onPressed: () async {
                final Uri appUri = Uri.parse(instagram!);
                if (await canLaunchUrl(appUri)) {
                  await launchUrl(appUri, mode: LaunchMode.externalApplication);
                  return;
                }
              }),
        if (linkedin != null && linkedin!.isNotEmpty)
          IconButton(
              icon: ImageWidget(imageUrl: ImageConst.linkedinSvg),
              onPressed: () async {
                final Uri appUri = Uri.parse(linkedin!);
                if (await canLaunchUrl(appUri)) {
                  await launchUrl(appUri, mode: LaunchMode.externalApplication);
                  return;
                }
              }),
      ],
    );
  }
}
