import 'package:another_flushbar/flushbar.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
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

supplierUserAlertPopup(BuildContext context, {Function()? onBack}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
            title: Column(children: [
              Icon(Icons.check_circle, color: AppColors.primaryColor, size: 60),
              SizedBox(height: 10),
              Text('Thank you for your interest!',
                  style: TextStyles.bold3(color: AppColors.black)),
              SizedBox(height: 10),
              Text('Our team will be in touch with you shortly.',
                  textAlign: TextAlign.center,
                  style: TextStyles.medium2(color: AppColors.lightGeryColor))
            ]),
            actions: [
              TextButton(
                  onPressed: onBack ??
                      () async {
                        navigationService.goBack();
                      },
                  child: Text("Done", style: TextStyles.medium4())),
            ]);
      });
}

viewProfileAlertPopup(BuildContext context, {String? title, String? subTitle}) {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            backgroundColor: AppColors.whiteColor,
            title: Column(
              children: [
                Text(title ?? 'Welcome! Your Profile Is Incomplete',
                    style: TextStyles.bold4(color: AppColors.primaryColor)),
                SizedBox(height: 18),
                Text(
                    subTitle ??
                        'To get the best experience, please update the required information to proceed.',
                    style: TextStyles.medium2(color: AppColors.black)),
                SizedBox(height: 12),
              ],
            ),
            actions: [
              AppButton(
                  width: 140,
                  height: 44,
                  text: 'Continue',
                  onTap: () => navigationService.goBack()),
            ]);
      });
}

scaffoldMessenger(String msg, {Color? color}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content:
          Text(msg, style: TextStyles.medium3(color: AppColors.whiteColor)),
      backgroundColor: color ?? AppColors.primaryColor,
      duration: const Duration(seconds: 2),
    ),
  );
}

showAlertMessage(BuildContext context, String message,
    {Function()? onBack, Function()? onCancel, String? yes, String? no}) {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            backgroundColor: AppColors.whiteColor,
            title: Text(message,
                style: TextStyles.medium3(color: AppColors.black)),
            actions: [
              TextButton(
                  onPressed: onCancel ??
                      () async {
                        navigationService.goBack();
                      },
                  child: Text(no ?? "Cancel", style: TextStyles.medium3())),
              TextButton(
                  onPressed: onBack,
                  child: Text(yes ?? "Ok", style: TextStyles.medium3())),
            ]);
      });
}

void showSignupSuccessDialog(
    BuildContext context, String email, Function()? onTap,
    {String? title, String? subTitle}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: AppColors.whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle,
                    color: AppColors.primaryColor, size: 60),
                const SizedBox(height: 20),
                Text(
                  title ?? "Verification Email Sent",
                  style: TextStyles.bold5(color: AppColors.black),
                ),
                const SizedBox(height: 15),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyles.medium3(
                        color: AppColors.PRIMARY_BLACK_COLOR),
                    children: [
                      TextSpan(text: "A verification email has been sent to "),
                      TextSpan(
                        text: email,
                        style:
                            TextStyles.medium3(color: AppColors.primaryColor),
                      ),
                      TextSpan(
                          text: subTitle ??
                              ". Please click the link to activate your account."),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Text('ok',
                        style:
                            TextStyles.medium4(color: AppColors.primaryColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showDeleteAccountDialog(BuildContext context, Function()? onTap) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Delete Account",
                    style: TextStyles.bold3(color: AppColors.primaryColor)),
                InkWell(
                    onTap: () => navigationService.goBack(),
                    child: Icon(Icons.close, color: AppColors.black))
              ]),
              Divider(color: AppColors.dividerColor),
              const SizedBox(height: 20),
              Text(
                "We're sorry to see you go.",
                style: TextStyles.bold3(color: AppColors.black),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                        text: 'Delete Account',
                        height: 40,
                        radius: 10,
                        width: 140,
                        onTap: onTap),
                    SizedBox(width: 10),
                    AppButton(
                        text: 'Cancel',
                        height: 40,
                        radius: 10,
                        width: 70,
                        btnColor: AppColors.lightGeryColor,
                        onTap: () => navigationService.goBack())
                  ],
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
    backgroundColor: AppColors.primaryColor,
    message: message,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
  ).show(context);
}

showUserBlockPopup(BuildContext context, String message,
    {Function()? confirmAction}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: AppColors.whiteColor,
            title: Text(message,
                style: TextStyles.medium3(color: AppColors.black)),
            actions: [
              TextButton(
                  onPressed: confirmAction,
                  child: Text(
                    "Confirm",
                    style: TextStyles.medium4(color: AppColors.primaryColor),
                  )),
              TextButton(
                  onPressed: () => navigationService.goBack(),
                  child: Text(
                    "Cancel",
                    style: TextStyles.medium4(),
                  )),
            ]);
      });
}

Future<void> showReportSuccessPopup(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Thanks for letting us know",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your report helps us keep the community safe. "
                "We’ll review this post and take appropriate action.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: 100,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showCourseCompletedDialog(BuildContext context, Function()? onPressed) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(22)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Course Completed",
                    style: TextStyles.bold3(color: AppColors.primaryColor)),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Icon(Icons.close,
                            size: 28, color: AppColors.black)))
              ]),
              SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Congratulations on completing the course. "
                    "Your certificate is now available for download.",
                    style: TextStyles.medium2(color: AppColors.black),
                  )),
              SizedBox(height: 30),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text("Claim Certificate",
                          style: TextStyles.medium3())),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showRejectPopup(BuildContext context,
    TextEditingController? controller, Function()? rejectOnTap) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reject Catalogue',
                  style: TextStyles.semiBold(
                      fontSize: 16, color: AppColors.primaryColor)),
              const SizedBox(height: 24),
              InputTextField(
                  title: 'Catalogue Rejection Reason',
                  isRequired: true,
                  controller: controller,
                  hintText: 'Enter rejection reason'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                AppButton(
                    text: 'cancel',
                    width: 90,
                    height: 38,
                    btnColor: AppColors.lightGeryColor,
                    borderColor: AppColors.lightGeryColor,
                    onTap: () {
                      navigationService.goBack();
                    }),
                SizedBox(width: 10),
                AppButton(
                    text: 'Reject', width: 90, height: 38, onTap: rejectOnTap),
              ])
            ],
          ),
        ),
      );
    },
  );
}
