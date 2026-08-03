import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/document_item.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/services/download_file.dart';
import 'package:flutter/material.dart';

class DocumentsCard extends StatelessWidget {
  final Supplies? suppliesDetails;

  const DocumentsCard({
    required this.suppliesDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final documents = [
      DocumentItem(
        title: "Product Brochure",
        file: suppliesDetails?.docBrochure,
      ),
      DocumentItem(
        title: "Product Warranty",
        file: suppliesDetails?.docWarranty,
      ),
      DocumentItem(
        title: "Product Specification Sheet",
        file: suppliesDetails?.docSpecSheet,
      ),
      DocumentItem(
        title: "Product Manual",
        file: suppliesDetails?.docManual,
      ),
      DocumentItem(
        title: "Safety Data Sheet",
        file: suppliesDetails?.docMsds,
      ),
    ];

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.description,
                              size: 18, color: AppColors.primaryColor),
                          const SizedBox(width: 4),
                          Text("DOCUMENTS",
                              style: TextStyles.bold2(color: Colors.black)),
                        ],
                      ),
                      Divider(color: Colors.grey.shade300, thickness: 1),
                      Column(
                        children: documents
                            .where((doc) => doc.file != null)
                            .map<Widget>(
                              (doc) => _documentRow(
                                doc.title,
                                doc.file!.size ?? 0,
                                doc.file!.url ?? "",
                                context
                              ),
                            )
                            .toList(),
                      )
                    ]))));
  }
}

_documentRow(String title, int size, String url, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () => downloadFile(context, url, fileName: title),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.picture_as_pdf, size: 20, color: AppColors.primaryColor),
              Text(title, style: TextStyles.bold2(color: AppColors.black)),
              Text("PDF - ${formatFileSize(size)}",
                  style: TextStyles.medium1(color: AppColors.geryColor)),
              Icon(Icons.download, size: 20, color: AppColors.primaryColor),
            ],
          ),
        ),
      ),
    ),
  );
}

String formatFileSize(int bytes) {
  if (bytes < 1024) {
    return "$bytes B";
  } else if (bytes < 1024 * 1024) {
    return "${(bytes / 1024).toStringAsFixed(2)} KB";
  } else {
    return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
  }
}
