import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AddDirectoryDocumentCard extends StatelessWidget {
  final String title;
  final String? imageFile;
  final Function()? onDelete;
  final Function()? onEdit;

  const AddDirectoryDocumentCard(
      {super.key,
      required this.title,
      this.imageFile,
      this.onDelete,
      this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardcolor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          if (imageFile != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Icon(Icons.picture_as_pdf),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              title,
              style: TextStyles.bold2(color: AppColors.black),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
              onTap: () async {
                if (await canLaunchUrl(Uri.parse(imageFile ?? ''))) {
                  await launchUrl(Uri.parse(imageFile ?? ''),
                      mode: LaunchMode.externalApplication);
                }
              },
              child:
                  Icon(Icons.download, size: 25, color: AppColors.greenColor)),
          SizedBox(width: 10),
          GestureDetector(
              onTap: onEdit,
              child: Icon(Icons.edit, color: AppColors.blueColor, size: 25)),
          SizedBox(width: 20),
          GestureDetector(
            onTap: onDelete,
            child: Icon(
              Icons.delete_outline,
              color: AppColors.redColor,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
