import 'dart:io';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/widgets/network_video_widget.dart';
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
final String? imageUrl;
  // Local Single file
  final File? selectedFile;
  final ValueChanged<File?>? onFilePicked;

  // Local Multiple files
  final List<File>? selectedFiles;
  final ValueChanged<List<File>>? onFilesPicked;

  // 🔹 Server Images
  final String? serverImage;
  final List<String>? serverImages;

  const ImagePickerField({

    super.key,
    this.title,
    this.isRequired = false,
    this.borderRadius = 8.0,
    this.hintText,
    this.imageUrl,
    this.showPreview = true,
    this.allowMultiple = false,
    this.selectedFile,
    this.onFilePicked,
    this.selectedFiles,
    this.onFilesPicked,
    this.serverImage,
    this.serverImages,
  });

  Future<void> _pickFile(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();

    if (allowMultiple) {
      if (source == ImageSource.gallery) {
        final pickedList = await picker.pickMultiImage(imageQuality: 80);
        if (pickedList.isNotEmpty) {
          final files = pickedList.map((e) => File(e.path)).toList();
          final validFiles = files.where((file) {
            final fileSizeMB = file.lengthSync() / (1024 * 1024);
            return fileSizeMB <= 5;
          }).toList();
          if (onFilesPicked != null) onFilesPicked!(validFiles);
        }
      } else if (source == ImageSource.camera) {
        final picked = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
        );
        if (picked != null) {
          final file = File(picked.path);
          final fileSizeMB = file.lengthSync() / (1024 * 1024);
          if (fileSizeMB > 5) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("File size must be under 5 MB")),
            );
            return;
          }
          if (onFilesPicked != null) onFilesPicked!([file]);
        }
      }
    } else {
      XFile? picked;
      if (source == ImageSource.camera) {
        picked = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
        );
      } else {
        picked = await picker.pickMedia(imageQuality: 80);
      }

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
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Choose Option",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOption(
                    icon: Icons.photo_library,
                    label: "Gallery",
                    color: Colors.blue,
                    onTap: () => _pickFile(context, ImageSource.gallery),
                  ),
                  _buildOption(
                    icon: Icons.camera_alt,
                    label: "Camera",
                    color: Colors.green,
                    onTap: () => _pickFile(context, ImageSource.camera),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasSingleFile = selectedFile != null;
    final hasMultipleFiles = selectedFiles != null && selectedFiles!.isNotEmpty;
    final hasServerSingle = serverImage != null && serverImage!.isNotEmpty;
    final hasServerMultiple = serverImages != null && serverImages!.isNotEmpty;

    return FormField<bool>(
      validator: (value) {
        if (isRequired &&
            !hasSingleFile &&
            !hasMultipleFiles &&
            !hasServerSingle &&
            !hasServerMultiple) {
          return "Please upload ${title ?? "file"}";
        }
        return null;
      },
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Row(
              children: [
                Text(title!, style: TextStyles.regular3(color: AppColors.black)),
                if (isRequired)
                  const Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => _showPickerSheet(context),
            child: DottedBorder(
              color: field.hasError ? Colors.red : Colors.grey.shade400,
              strokeWidth: 1.5,
              dashPattern: const [6, 4],
              borderType: BorderType.RRect,
              radius: Radius.circular(borderRadius),
              child: Container(
                width: double.infinity,
                height: showPreview ? 150 : null,
                alignment: Alignment.center,
                child: hasMultipleFiles
                    ? _buildLocalMultipleFiles()
                    : hasSingleFile
                        ? _buildLocalSingleFile()
                        : hasServerMultiple
                            ? _buildServerMultipleFiles()
                            : hasServerSingle
                                ? _buildServerSingleFile()
                                : _buildPlaceholder(),
              ),
            ),
          ),
          if (field.hasError) ...[
            const SizedBox(height: 5),
            Text(
              field.errorText ?? "",
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ]
        ],
      ),
    );
  }

  // 🔹 Preview helpers
  Widget _buildLocalMultipleFiles() => ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: selectedFiles!.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final file = selectedFiles![index];
          final isVideo = file.path.toLowerCase().endsWith(".mp4");
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: isVideo
                ? const Icon(Icons.videocam, size: 50, color: Colors.grey)
                : Image.file(file, fit: BoxFit.contain),
          );
        },
      );

  Widget _buildLocalSingleFile() => selectedFile!.path
          .toLowerCase()
          .endsWith(".mp4")
      ? const Icon(Icons.videocam, size: 50, color: Colors.grey)
      : Image.file(selectedFile!, fit: BoxFit.contain, width: double.infinity);

  Widget _buildServerMultipleFiles() => ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: serverImages!.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final url = serverImages![index];
          final isVideo = url.toLowerCase().endsWith(".mp4");
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: isVideo
                ? const Icon(Icons.videocam, size: 50, color: Colors.grey)
                : Image.network(url, fit: BoxFit.contain),
          );
        },
      );

  Widget _buildServerSingleFile() => serverImage!.toLowerCase().endsWith(".mp4")
      ? const Icon(Icons.videocam, size: 50, color: Colors.grey)
      : Image.network(serverImage!,
          fit: BoxFit.contain, width: double.infinity);
          //NetworkVideoWidget(url: serverImage!)

  Widget _buildPlaceholder() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageConst.upload),
          const SizedBox(height: 20),
          Text("Click here to Choose a file.",
              style: TextStyles.medium2(color: AppColors.black)),
          const SizedBox(height: 8),
          Text(
            hintText ?? "JPEG, PNG formats, up to 5 MB each",
            style: TextStyles.regular2(color: AppColors.dropDownHint),
          ),
        ],
      );
}
