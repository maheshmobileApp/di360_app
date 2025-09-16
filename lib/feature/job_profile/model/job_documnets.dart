import 'dart:io';

class UploadedDocument {
  final String title;   
  final File file;     

  UploadedDocument({
    required this.title, 
    required this.file});
}
