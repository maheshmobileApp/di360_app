import 'package:another_flushbar/flushbar.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';

alertPopup(BuildContext context, String message, {Function()? onBack}) {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            title: Text(message,
                style: TextStyles.medium3(color: AppColors.black)),
            actions: [
              TextButton(
                  onPressed: onBack ??
                      () async {
                        navigationService.goBack();
                      },
                  child: Text(
                    "Ok",
                    style: TextStyles.medium4(),
                  )),
            ]);
      });
}

scaffoldMessenger(String msg, {Color? color}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content:
          Text(msg, style: TextStyles.medium3(color: AppColors.whiteColor)),
      backgroundColor:
          color ?? AppColors.primaryColor,
      duration:
          const Duration(seconds: 2),
    ),
  );
}

showAlertMessage(BuildContext context, String message, {Function()? onBack}) {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
            title: Text(message,
                style: TextStyles.medium3(color: AppColors.black)),
            actions: [
              TextButton(
                  onPressed: () async {
                    navigationService.goBack();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyles.medium4(),
                  )),
              TextButton(
                  onPressed: onBack,
                  child: Text(
                    "Ok",
                    style: TextStyles.medium4(),
                  )),
            ]);
      });
}

void showSignupSuccessDialog(
    BuildContext context, String email, Function()? onTap) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: AppColors.primaryColor, size: 60),
              const SizedBox(height: 20),
              Text(
                "Sign up successful",
                style: TextStyles.bold5(color: AppColors.black),
              ),
              const SizedBox(height: 15),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style:
                      TextStyles.medium3(color: AppColors.PRIMARY_BLACK_COLOR),
                  children: [
                    TextSpan(text: "A verification link has been sent to "),
                    TextSpan(
                      text: email,
                      style: TextStyles.medium3(color: AppColors.primaryColor),
                    ),
                    TextSpan(
                        text:
                            ". Please click on the link to activate the account."),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: onTap,
                  child: Text('ok',
                      style: TextStyles.medium4(color: AppColors.primaryColor)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showTopMessage(BuildContext context, String message) {
  Flushbar(
    message: message,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
  ).show(context);
}
