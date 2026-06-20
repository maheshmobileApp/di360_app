import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/utils/share_utils.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareWidget extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String feedId;
  final String? category;
  final double? size;
  const ShareWidget({super.key, this.padding, this.size, required this.feedId, this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final RenderBox? box = context.findRenderObject() as RenderBox?;
          final Rect sharePositionOrigin = box != null
              ? box.localToGlobal(Offset.zero) & box.size
              : Rect.fromLTWH(0, 0, 1, 1);

          final link = category != null
              ? ShareUtils.getShareUrlDeepling(feedId, category ?? "")
              : ShareUtils.getShareUrl(feedId);

          SharePlus.instance.share(ShareParams(
            uri: Uri.parse(link),
            sharePositionOrigin: sharePositionOrigin,
          ));
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.backgroundColor),
            child: Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Icon(Icons.share,
                    color: AppColors.primaryColor, size: size))));
  }
}
