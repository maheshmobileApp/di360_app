import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExperienceInfo extends StatelessWidget {
  final String svgPath;
    final String text;

  const ExperienceInfo({super.key, required this.svgPath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          svgPath,
          colorFilter: ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(text,
            style: TextStyles.regular1(color: AppColors.locationTextColor)),
        ),
      ],
    );
  }
}