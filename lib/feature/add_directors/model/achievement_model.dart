import 'dart:io';

class AchievementModel {
  final String name;
  final File? imageFile;
  AchievementModel({
    required this.name,
    this.imageFile,
  });
}