import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWithTitle extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;

  const IconWithTitle({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            
            iconPath,
            colorFilter: ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.medium2(),
                ),
                SizedBox(height: 4),
                Text(subtitle,
                    style: TextStyles.regular1(
                        color: AppColors.locationTextColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
