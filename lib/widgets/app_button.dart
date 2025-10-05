import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final double? height;
  final double? width;
  final double radius;
  const AppButton(
      {super.key, required this.text, this.onTap, this.height, this.width, this.radius = 50});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 60,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(radius)),
        child: Center(
            child: Text(text,
                style: TextStyles.medium3(color: AppColors.whiteColor))),
      ),
    );
  }
}
