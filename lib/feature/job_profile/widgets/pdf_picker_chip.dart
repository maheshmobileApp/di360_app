import 'dart:io';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PdfPickerChip extends StatelessWidget {
  final String title;
  final bool isRequired;
  final File? file;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const PdfPickerChip({
    super.key,
    required this.title,
    this.isRequired = false,
    required this.file,
    required this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasFile = file != null;
    final String fileName = hasFile ? file!.path.split('/').last : "Upload $title (PDF only)";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
            color: Colors.grey.shade400,
            strokeWidth: 1.5,
            dashPattern: const [6, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      fileName,
                      maxLines: 2,
                      style: hasFile
                          ? const TextStyle(fontSize: 14, color: Colors.black)
                          : TextStyle(fontSize: 14, color: Colors.grey.shade500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                 Image.asset(
                      ImageConst.upload,
                    ),
                ],
              ),
            ),
          ),
        ),

        if (hasFile) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(fileName, style: const TextStyle(fontSize: 13, color: Colors.black87))),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red, size: 20),
                onPressed: onRemove,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
