import 'dart:io';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  final String? title;
  final bool isRequired;
  final double borderRadius;
  final Color? titleColor;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool showPreview; // if true shows image, else file name

  const ImagePickerField({
    super.key,
    this.title,
    this.isRequired = false,
    this.borderRadius = 8.0,
    this.titleColor,
    this.hintStyle,
    this.hintText,
    this.showPreview = true,
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  bool _isFileValid(File file) {
    final fileSizeInBytes = file.lengthSync();
    final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    return fileSizeInMB <= 5; // only allow <= 5 MB
  }

  Future<void> _pickFile(ImageSource source) async {
    final picked = await _picker.pickMedia(
      imageQuality: 80, // applies if it's an image
    );

    if (picked != null) {
      final file = File(picked.path);

      // ✅ Validate size
      if (!_isFileValid(file)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("File size must be under 5 MB")),
        );
        return;
      }

      setState(() => _selectedFile = file);
    }
    Navigator.pop(context);
  }

  void _showPickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () => _pickFile(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () => _pickFile(ImageSource.camera),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasFile = _selectedFile != null;
    final String fileName = hasFile
        ? _selectedFile!.path.split('/').last
        : (widget.hintText ?? 'JPEG, PNG formats, up to 5 MB');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Row(
            children: [
              Text(
                widget.title!,
                style: TextStyles.regular3(color: AppColors.black),
              ),
              if (widget.isRequired)
                const Text(
                  ' *',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _showPickerSheet,
          child: DottedBorder(
            color: Colors.grey.shade400,
            strokeWidth: 1.5,
            dashPattern: const [6, 4],
            borderType: BorderType.RRect,
            radius: Radius.circular(widget.borderRadius),
            child: Container(
              width: double.infinity,
              height: widget.showPreview ? 150 : null,
              padding: widget.showPreview
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              alignment: Alignment.center,
              child: hasFile
                  ? widget.showPreview
                      ? _selectedFile!.path.toLowerCase().endsWith(".mp4")
                          ? const Icon(Icons.videocam,
                              size: 50, color: Colors.grey)
                          : Image.file(_selectedFile!,
                              fit: BoxFit.cover, width: double.infinity)
                      : Text(fileName, overflow: TextOverflow.ellipsis)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(ImageConst.upload),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.timeBgColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Click here to Choose a file.",
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "JPEG, PNG formats, up to 5 MB",
                          style: TextStyles.regular2(
                              color: AppColors.dropDownHint),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
