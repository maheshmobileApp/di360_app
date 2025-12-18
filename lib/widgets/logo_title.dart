import 'package:di360_flutter/common/constants/app_colors.dart';
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
  const LogoWithTitle({super.key, required this.title, required this.createdAt, required this.role, required this.imageUrl, required this.showTime});

  @override
  Widget build(BuildContext context) {
    return  Row(
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
              child: (imageUrl != '' || imageUrl.isNotEmpty)
                  ? ClipOval(
                      child: CachedNetworkImageWidget(
                          width: 48,
                          height: 48,
                          imageUrl: imageUrl,
                          errorWidget: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.error),
                          )))
                  : CircleAvatar(
                      radius: 24,
                      child: Icon(Icons.person),
                      backgroundColor: Colors.grey,
                    ),
            )),
                 SizedBox(width: 12),
                // Title & Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ,
                      style:TextStyles.medium3()
                    ),
                    SizedBox(height: 4),
                    Text(
                      role ,
                      style: TextStyles.regular2()
                    ),
                  ],
                ),
              ],
            ),
          showTime?  Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
            ):SizedBox.shrink(),
          ],
        );
  }
}