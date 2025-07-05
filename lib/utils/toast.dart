import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static void show(String message) {
    // Implement your toast message logic here
    // For example, using Flutter's built-in SnackBar or a third-party package
      Fluttertoast.showToast(
                    msg: 'Failed to send enquiry. Please try again.',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
  }
}