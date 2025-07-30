import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class DirectorBasicInfo extends StatelessWidget {
  const DirectorBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12,top: 16,bottom: 6),
          child: Text('BASIC INFO', style: TextStyles.medium2(color: AppColors.black)),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
          child: Text(
              'The entire course was re-recorded from scratch and was therefore completely updated! It’s now 100% up-to-date with the latest version of Angular again, covering crucial modern features like signals, standalone components etc. Many new deep-dive sections on these core topics were added, hence ensuring that you learn ALL about modern Angular in-depth. In addition, the course also still covers older Angular versions & syntax, so that you get the most out of this course, no matter with which Angular version you’re working.The entire course was re-recorded from scratch …',
              style: TextStyles.dmsansLight(fontSize: 14, color: AppColors.black)),
        )
      ],
    );
  }
}
