import 'dart:io';
class ServiceModel {
  final String name;
  final bool appointment;
  final String description;
  final File? imageFile;

  ServiceModel({
    required this.name,
    required this.appointment,
    required this.description,
    this.imageFile,
  });
}