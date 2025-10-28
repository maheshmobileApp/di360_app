import 'dart:io';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageSelection extends StatefulWidget {
  final String? title;
  final bool isRequired;
  final List<File> images;
  final Function(List<File>) onChanged;
  final double borderRadius;
  final Color? titleColor;

  const CustomImageSelection({
    super.key,
    this.title,
    this.isRequired = false,
    required this.images,
    required this.onChanged,
    this.borderRadius = 8.0,
    this.titleColor,
  });

  @override
  State<CustomImageSelection> createState() => _CustomImageSelectionState();
}

class _CustomImageSelectionState extends State<CustomImageSelection> with BaseContextHelpers {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 75);
    if (picked != null) {
      final newList = [...widget.images, File(picked.path)];
      widget.onChanged(newList);
    }
   // Navigator.pop(context);
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
              title: const Text('Gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                 Text(
                  ' *',
                 style: TextStyles.bold3(color: AppColors.redColor),
                ),
            ],
          ),
         addVertical(8),
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
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConst.upload,
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Upload Photo',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        addHorizontal(10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: widget.images.map((file) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      file,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 1,
                  top: 2,
                  child: GestureDetector(
                    onTap: () {
                      final newList = [...widget.images]..remove(file);
                      widget.onChanged(newList);
                    },
                    child: Container(
                      decoration:  BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      padding:  EdgeInsets.all(4),
                      child:  Icon(Icons.close, size: 14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
