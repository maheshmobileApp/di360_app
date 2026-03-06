import 'package:flutter/material.dart';

class AppResetService {
  static final ValueNotifier<int> resetSignal = ValueNotifier<int>(0);

  static void resetAppState() {
    resetSignal.value++;
  }
}