import 'dart:io';

class CertificateModel {
  final String name;
  final File? imageFile;
  
 CertificateModel({
    required this.name,
    this.imageFile,
  });
}