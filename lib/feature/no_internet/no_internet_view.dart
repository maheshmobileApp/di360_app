
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget with BaseContextHelpers {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_outlined,
              size: 80,
            ),
            addVertical(10),
            Text(
              "No Internet Connection",
              style: TextStyles.medium3(
                  color: AppColors.primaryBlueColor,
                  fontSize: 20,
                 ),
              textAlign: TextAlign.end,
            ),
            addVertical(6),
            Text(
              "Please check your network settings and try again.",
              style: TextStyles.medium3(
                  color: AppColors.black,
                  fontSize: 14,
                  ),
              textAlign: TextAlign.center,
            ),
            addVertical(30),
            AppButton(
              height: 50,
              
              text: "Try Again",
              onTap: ()  {
                ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:
          Text("Still no Internet Connection", style: TextStyles.medium3(color: AppColors.whiteColor)),
      backgroundColor:
           AppColors.primaryColor, // Customize the background color
      duration:
          const Duration(seconds: 2),)
      );
              },
              width: 180,
            )
          ],
        ),
      ),
    );
  }
}
