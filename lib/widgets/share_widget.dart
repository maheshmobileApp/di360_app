import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/utils/share_utils.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareWidget extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String feedId;
  final double? size;
  const ShareWidget({super.key, this.padding, this.size, required this.feedId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final link = ShareUtils.getShareUrl(feedId);
          SharePlus.instance.share(ShareParams(uri: Uri.parse(link)));
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.backgroundColor),
            child: Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(horizontal: 10, vertical:6),
                child: Icon(Icons.share,
                    color: AppColors.primaryColor, size: size))));
  }
}
