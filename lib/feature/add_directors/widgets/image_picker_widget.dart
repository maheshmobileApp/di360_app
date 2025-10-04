import 'dart:io';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImagePickerInputField extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final File? imageFile;
  final VoidCallback onTap;
  final String? hintText;
  final double borderRadius;
  final Color? titleColor;
  final TextStyle? hintStyle;

  const ImagePickerInputField({
    super.key,
    this.title,
    this.isRequired = false,
    required this.imageFile,
    required this.onTap,
    this.hintText,
    this.borderRadius = 8.0,
    this.titleColor,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasFile = imageFile != null;
    final String fileName = hasFile
        ? imageFile!.path.split('/').last
        : (hintText ?? 'JPEG, PNG, PDF formats, up to 5 MB');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              Text(
                title!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? Colors.black,
                ),
              ),
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
          onTap: onTap,
          child: DottedBorder(
            color: Colors.grey.shade400,
            strokeWidth: 1.5,
            dashPattern: const [6, 4],
            borderType: BorderType.RRect,
            radius: Radius.circular(borderRadius),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      fileName,
                      style: hasFile
                          ? const TextStyle(fontSize: 14, color: Colors.black)
                          : hintStyle ??
                              TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(
                      ImageConst.upload,
                    ),
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

void imagePickerSelection(
    BuildContext context, Function()? galleryOnTap, Function()? cameraOnTap) {
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
                buildOption(
                  icon: Icons.photo_library,
                  label: "Gallery",
                  color: Colors.blue,
                  onTap: galleryOnTap ?? () {},
                ),
                buildOption(
                  icon: Icons.camera_alt,
                  label: "Camera",
                  color: Colors.green,
                  onTap: cameraOnTap ?? () {},
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

Widget buildOption({
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
