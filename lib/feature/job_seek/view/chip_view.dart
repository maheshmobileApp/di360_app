import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class ChipView extends StatelessWidget {
  final String? type;
  const ChipView({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: AppColors.blueColor, // Border color
          width: 1.0, // Border width
        ),
      ),
      backgroundColor: AppColors.blueColor.withOpacity(0.15),
      label: Text(
        type.toString(),
        style: TextStyles.regular1(color: AppColors.blueColor),
      ),
    );
  }
}

Widget customFilterChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    margin: EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
      color: AppColors.secondaryBlueColor,
      borderRadius: BorderRadius.circular(16), // Adjust radius here
    ),
    child: Text(
      label,
      style: TextStyle(color: AppColors.primaryBlueColor),
    ),
  );
}
