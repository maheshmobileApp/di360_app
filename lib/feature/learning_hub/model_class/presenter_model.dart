import 'dart:io';
import 'package:flutter/material.dart';

class PresenterModel {
  final TextEditingController presenterNameController = TextEditingController();
  File? presenterImage;
  String? serverPresenterImage;

  PresenterModel();

  void dispose() {
    presenterNameController.dispose();
  }
}
