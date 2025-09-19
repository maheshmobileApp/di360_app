import 'dart:io';
import 'package:flutter/material.dart';

class SessionModel {
  final TextEditingController sessionNameController;
  final TextEditingController sessionInfoController;
  final TextEditingController eventDateController;
  List<File>? images;

  SessionModel({
    String? sessionName,
    String? sessionInfo,
    String? eventDate,
    this.images,
  })  : sessionNameController = TextEditingController(text: sessionName),
        sessionInfoController = TextEditingController(text: sessionInfo),
        eventDateController = TextEditingController(text: eventDate);
}
