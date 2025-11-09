import 'dart:io';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PdfPickerChip extends StatelessWidget {
  final String title;
  final bool isRequired;
  final File? file;
  final String? serverFileName;   // <----- NEW
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const PdfPickerChip({
    super.key,
    required this.title,
    this.isRequired = false,
    required this.file,
    required this.serverFileName, // <----- NEW REQUIRED
    required this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasLocal = file != null;
    final bool hasServer = !hasLocal && serverFileName != null && serverFileName!.isNotEmpty;

    final String displayTop = hasLocal
        ? file!.path.split('/').last
        : "Upload $title (PDF only)";

    // bottom row name
    String? bottomName;
    if (hasLocal) {
      bottomName = file!.path.split('/').last;
    } else if (hasServer) {
      bottomName = serverFileName;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            if (isRequired)
              const Text(' *', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
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
                      displayTop,
                      maxLines: 2,
                      style: hasLocal
                          ? const TextStyle(fontSize: 14, color: Colors.black)
                          : TextStyle(fontSize: 14, color: Colors.grey.shade500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Image.asset(ImageConst.upload),
                ],
              ),
            ),
          ),
        ),

        if (bottomName != null) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  bottomName,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
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
