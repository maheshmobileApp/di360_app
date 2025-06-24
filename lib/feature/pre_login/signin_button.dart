import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigninButton extends StatelessWidget with BaseContextHelpers {
  final String text;
  final String img;
  final Function()? onTap;
  const SigninButton(
      {super.key, required this.text, required this.img, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.black, borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyles.medium3(color: AppColors.whiteColor)),
            addHorizontal(13),
            SvgPicture.asset(img)
          ],
        ),
      ),
    );
  }
}
