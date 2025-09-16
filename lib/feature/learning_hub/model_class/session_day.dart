import 'dart:io';
import 'package:flutter/material.dart';

class SessionDay {
  final TextEditingController sessionNameController;
  final TextEditingController sessionInfoController;
  //List<File> selectedEventImgs; // images per day

  SessionDay({
    String? sessionName,
    String? sessionInfo,
  })  : sessionNameController = TextEditingController(text: sessionName),
        sessionInfoController = TextEditingController(text: sessionInfo);

  void dispose() {
    sessionNameController.dispose();
    sessionInfoController.dispose();
  }
}
