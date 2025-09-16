import 'dart:io';
import 'package:flutter/material.dart';

class SessionModel {
  final TextEditingController sessionNameController;
  final TextEditingController sessionInfoController;
  List<File>? images;

  SessionModel({
    String? sessionName,
    String? sessionInfo,
    this.images,
  })  : sessionNameController = TextEditingController(text: sessionName),
        sessionInfoController = TextEditingController(text: sessionInfo);
}
