import 'package:di360_flutter/main.dart';
import 'package:flutter/material.dart';


class BannerLoaders {
  static void circularShowLoader() {
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void circularHideLoader() {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    }
  }
}
