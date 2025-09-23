import 'dart:io';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends FormField<List<File>> {
  ImagePickerField({
    Key? key,
    String? title,
    bool isRequired = false,
    double borderRadius = 8.0,
    String? hintText,
    bool showPreview = true,
    bool allowMultiple = false,
    File? selectedFile,
    List<File>? selectedFiles,
    ValueChanged<File?>? onFilePicked,
    ValueChanged<List<File>>? onFilesPicked,
    FormFieldValidator<List<File>>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          key: key,
          initialValue: allowMultiple
              ? (selectedFiles ?? [])
              : (selectedFile != null ? [selectedFile] : []),
          validator: (files) {
            if (isRequired && (files == null || files.isEmpty)) {
              return "This field is required";
            }
            if (validator != null) {
              return validator(files);
            }
            return null;
          },
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<List<File>> state) {
            final hasFiles = state.value != null && state.value!.isNotEmpty;
            final singleFile =
                !allowMultiple && hasFiles ? state.value!.first : null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Row(
                    children: [
                      Text(title,
                          style: TextStyles.regular3(color: AppColors.black)),
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
                  onTap: () {
                    _showPickerSheet(
                      state.context,
                      allowMultiple,
                      (picked) {
                        if (allowMultiple) {
                          state.didChange(picked ?? []);
                          if (onFilesPicked != null)
                            onFilesPicked!(picked ?? []);
                        } else {
                          state.didChange(picked != null ? [picked.first] : []);
                          if (onFilePicked != null) {
                            onFilePicked!(picked != null ? picked.first : null);
                          }
                        }
                      },
                    );
                  },
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
                      child: hasFiles
                          ? allowMultiple
                              ? ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.value!.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 10),
                                  itemBuilder: (_, index) {
                                    final file = state.value![index];
                                    final isVideo = file.path
                                        .toLowerCase()
                                        .endsWith(".mp4");
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: isVideo
                                          ? const Icon(Icons.videocam,
                                              size: 50, color: Colors.grey)
                                          : Image.file(file,
                                              fit: BoxFit.contain),
                                    );
                                  },
                                )
                              : (singleFile!.path.toLowerCase().endsWith(".mp4")
                                  ? const Icon(Icons.videocam,
                                      size: 50, color: Colors.grey)
                                  : Image.file(
                                      singleFile,
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                    ))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(ImageConst.upload),
                                const SizedBox(height: 20),
                                Text(
                                  "Click here to Choose a file.",
                                  style: TextStyles.medium2(
                                      color: AppColors.black),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  hintText ??
                                      "JPEG, PNG formats, up to 5 MB each",
                                  style: TextStyles.regular2(
                                      color: AppColors.dropDownHint),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 4),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );

  /// helper to reuse your bottom sheet logic
  static void _showPickerSheet(
    BuildContext context,
    bool allowMultiple,
    ValueChanged<List<File>?> onPicked,
  ) {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        Future<void> pickFromGallery() async {
          if (allowMultiple) {
            final pickedList = await picker.pickMultiImage(imageQuality: 80);
            if (pickedList.isNotEmpty) {
              final files = pickedList.map((e) => File(e.path)).toList();
              final validFiles = files
                  .where((f) => f.lengthSync() / (1024 * 1024) <= 5)
                  .toList();
              onPicked(validFiles);
            }
          } else {
            final picked = await picker.pickMedia(imageQuality: 80);
            if (picked != null) {
              final file = File(picked.path);
              if (file.lengthSync() / (1024 * 1024) > 5) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("File size must be under 5 MB")),
                );
              } else {
                onPicked([file]);
              }
            }
          }
          Navigator.pop(context);
        }

        Future<void> pickFromCamera() async {
          final picked = await picker.pickImage(
              source: ImageSource.camera, imageQuality: 80);
          if (picked != null) {
            final file = File(picked.path);
            if (file.lengthSync() / (1024 * 1024) > 5) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("File size must be under 5 MB")),
              );
            } else {
              onPicked([file]);
            }
          }
          Navigator.pop(context);
        }

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
                    onTap: pickFromGallery,
                  ),
                  _buildOption(
                    icon: Icons.camera_alt,
                    label: "Camera",
                    color: Colors.green,
                    onTap: pickFromCamera,
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

  static Widget _buildOption({
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
}
