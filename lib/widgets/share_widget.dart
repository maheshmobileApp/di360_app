import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareWidget extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final double? size;
  const ShareWidget({super.key, this.padding, this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          SharePlus.instance.share(ShareParams(
              uri: Uri(
                  path:
                      'https://api.dentalinterface.com/api/v1/prelogin/9dab6d94-589e-46f7-ab39-9156d62afa7b')));
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
