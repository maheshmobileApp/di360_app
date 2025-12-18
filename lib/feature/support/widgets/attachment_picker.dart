import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttachmentPicker extends StatelessWidget {
  final String icon;
  final double size;
  final Function(PlatformFile file) onPick;

  const AttachmentPicker({
    super.key,
    required this.icon,
    required this.onPick,
    this.size = 25,
  });

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf','doc', 'docx','png','jpg','jpeg'],
    );

    if (result != null && result.files.isNotEmpty) {
      onPick(result.files.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickFile,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          icon,
          height: size,
          width: size,
        ),
      ),
    );
  }
}
