import 'dart:io';

import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';

class UploadSection extends StatelessWidget {
  final String sectionTitle;
  final bool isRequired;
  final String titleInsideBox;
  final String subTitleInsideBox;
  final bool showTrailingIcon;
  final VoidCallback onTap;
  final double? boxHeight;

  const UploadSection({
    super.key,
    required this.sectionTitle,
    this.isRequired = false,
    required this.titleInsideBox,
    required this.subTitleInsideBox,
    this.showTrailingIcon = false,
    required this.onTap,
    this.boxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final addCataloguVM = Provider.of<AddCatalogueViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        RichText(
          text: TextSpan(
            text: sectionTitle,
            style: TextStyles.regular3(color: AppColors.black),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ],
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
            dashPattern: const [6, 4],
            color: Colors.grey,
            strokeWidth: 1.5,
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            child: Container(
              height: boxHeight, // ← dynamic height
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(children: [
                Expanded(
                  child: subTitleInsideBox.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                              addCataloguVM.pdfPath != null
                                  ? addCataloguVM.pdfPath!.split('/').last
                                  : titleInsideBox,
                              style: addCataloguVM.pdfPath != null
                                  ? TextStyles.medium2(color: AppColors.black)
                                  : TextStyles.regular1(
                                      color: AppColors.dropDownHint)),
                        )
                      : addCataloguVM.thumbnailImagePath != null
                          ? Image.file(File(addCataloguVM.thumbnailImagePath!),
                              fit: BoxFit.cover)
                          : addCataloguVM.thumbnailServerPath != null
                              ? Image.network(
                                  addCataloguVM.thumbnailServerPath ?? '',
                                  fit: BoxFit.cover)
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(ImageConst.upload),
                                    const SizedBox(height: 12),
                                    Text(
                                      titleInsideBox,
                                      style: TextStyles.medium2(
                                          color: AppColors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      subTitleInsideBox,
                                      style: TextStyles.regular1(
                                          color: AppColors.dropDownHint),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                ),
                if (showTrailingIcon) Image.asset(ImageConst.upload)
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
