import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class LogoWithTitle extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String createdAt;
  final String role;
  final bool showTime;
  final bool postAnonymously;
  const LogoWithTitle(
      {super.key,
      required this.title,
      required this.createdAt,
      required this.role,
      required this.imageUrl,
      required this.showTime,
      required this.postAnonymously});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Circle avatar or logo
            CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 24,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.whiteColor,
                  child: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primaryColor,
                      child: ClipOval(
                          child: CachedNetworkImageWidget(
                        width: 48,
                        height: 48,
                        imageUrl: postAnonymously ? "" :imageUrl,
                        errorWidget: Image.asset(ImageConst.directorProfile),
                      ))),
                )),
            SizedBox(width: 12),
            // Title & Subtitle
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!postAnonymously)
                Text(title, style: TextStyles.medium3()),
                SizedBox(height: 4),
                Text(role, style: TextStyles.medium3()),
              ],
            ),
          ],
        ),
        showTime
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade50, Colors.white],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  Jiffy.parse(createdAt).fromNow(),
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
