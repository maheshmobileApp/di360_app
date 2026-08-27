import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';

class DocumentItem {
  final String title;
  final Image? file; // Replace FileModel with your actual document model

  DocumentItem({
    required this.title,
    this.file,
  });
}