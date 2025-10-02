import 'dart:io';
import 'package:flutter/material.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';

class SessionModel {
  final TextEditingController sessionNameController;
  final TextEditingController sessionInfoController;
  final TextEditingController eventDateController;
  List<File>? images; // new images picked
  List<String> serverImages; // server image URLs

  SessionModel({
    String? sessionName,
    String? sessionInfo,
    String? eventDate,
    this.images,
    List<Images>? serverImagesList, // input from API
  })  : sessionNameController = TextEditingController(text: sessionName),
        sessionInfoController = TextEditingController(text: sessionInfo),
        eventDateController = TextEditingController(text: eventDate),
        serverImages = serverImagesList
                ?.map((img) => img.url ?? "")
                .where((url) => url.isNotEmpty)
                .toList() ??
            [];
}
