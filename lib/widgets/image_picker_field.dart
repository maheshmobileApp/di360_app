import 'dart:io';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImagePickerField extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final double borderRadius;
  final String? hintText;
  final bool showPreview;
  final bool allowMultiple;

  // Single file
  final File? selectedFile;
  final ValueChanged<File?>? onFilePicked;

  // Multiple files
  final List<File>? selectedFiles;
  final ValueChanged<List<File>>? onFilesPicked;

  const ImagePickerField({
    super.key,
    this.title,
    this.isRequired = false,
    this.borderRadius = 8.0,
    this.hintText,
    this.showPreview = true,
    this.allowMultiple = false,
    this.selectedFile,
    this.onFilePicked,
    this.selectedFiles,
    this.onFilesPicked,
  });

  Future<void> _pickFile(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();

    if (allowMultiple) {
      final pickedList = await picker.pickMultiImage(imageQuality: 80);
      if (pickedList.isNotEmpty) {
        final files = pickedList.map((e) => File(e.path)).toList();

        // ✅ Filter size < 5MB
        final validFiles = files.where((file) {
          final fileSizeMB = file.lengthSync() / (1024 * 1024);
          return fileSizeMB <= 5;
        }).toList();

        if (onFilesPicked != null) onFilesPicked!(validFiles);
      }
    } else {
      final picked = await picker.pickMedia(imageQuality: 80);
      if (picked != null) {
        final file = File(picked.path);

        final fileSizeMB = file.lengthSync() / (1024 * 1024);
        if (fileSizeMB > 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("File size must be under 5 MB")),
          );
          return;
        }

        if (onFilePicked != null) onFilePicked!(file);
      }
    }

    Navigator.pop(context);
  }

  void _showPickerSheet(BuildContext context) {
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
              title: Text(allowMultiple ? "Gallery" : "Gallery"),
              onTap: () => _pickFile(context, ImageSource.gallery),
            ),
            if (!allowMultiple) // Camera only when single selection
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => _pickFile(context, ImageSource.camera),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasSingleFile = selectedFile != null;
    final hasMultipleFiles = selectedFiles != null && selectedFiles!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              Text(title!, style: TextStyles.regular3(color: AppColors.black)),
              if (isRequired)
                const Text(' *',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _showPickerSheet(context),
          child: DottedBorder(
            color: Colors.grey.shade400,
            strokeWidth: 1.5,
            dashPattern: const [6, 4],
            borderType: BorderType.RRect,
            radius: Radius.circular(borderRadius),
            child: Container(
              width: double.infinity,
              height: showPreview ? 150 : null,
              alignment: Alignment.center,
              child: hasMultipleFiles
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedFiles!.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (_, index) {
                        final file = selectedFiles![index];
                        final isVideo = file.path.toLowerCase().endsWith(".mp4");
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: isVideo
                              ? const Icon(Icons.videocam,
                                  size: 50, color: Colors.grey)
                              : Image.file(file,
                                  fit: BoxFit.cover, width: 120, height: 120),
                        );
                      },
                    )
                  : hasSingleFile
                      ? (selectedFile!.path.toLowerCase().endsWith(".mp4")
                          ? const Icon(Icons.videocam,
                              size: 50, color: Colors.grey)
                          : Image.file(selectedFile!,
                              fit: BoxFit.cover, width: double.infinity))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(ImageConst.upload),
                            const SizedBox(height: 20),
                            Text("Click here to Choose a file.",
                                style: TextStyles.medium2(
                                    color: AppColors.black)),
                            const SizedBox(height: 8),
                            Text(
                                hintText ??
                                    "JPEG, PNG formats, up to 5 MB each",
                                style: TextStyles.regular2(
                                    color: AppColors.dropDownHint)),
                          ],
                        ),
            ),
          ),
        ),
      ],
    );
  }
}
