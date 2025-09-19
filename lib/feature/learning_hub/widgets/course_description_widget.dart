import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class CourseDescriptionWidget extends StatelessWidget {
  final String title;
  final String description;
  const CourseDescriptionWidget(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.bold2(color: AppColors.primaryColor),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}
