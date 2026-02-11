
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({super.key, this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CupertinoActivityIndicator(
          //  color: AppColors.primaryColor,
          radius: 20,
        ),
        const SizedBox(width: 20),
        Text(message ?? "Loading,please wait...")
      ],
    ));
  }
}

showLoader(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingWidget(message: message),
            ],
          ),
        );
      });
}

hideLoader() {
  navigationService.goBack();
}

class Loaders {

  static circularShowLoader(BuildContext context) {
EasyLoading.show(status: 'Loading...');

  }
  static circularHideLoader(BuildContext context) {
    EasyLoading.dismiss();
  }
}

FormData convertMapToFormData(Map<String, dynamic> payload) {
  return FormData.fromMap(payload);
}
