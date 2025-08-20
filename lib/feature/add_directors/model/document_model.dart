import 'dart:io';

class DocumentModel {
  final String name;
  final File? imageFile;
  
  DocumentModel({
    required this.name,
    this.imageFile,
  });
}