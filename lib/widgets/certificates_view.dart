import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/model/certificates.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/catalogue/view/horizantal_pdf.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';

class CertificatesView extends StatelessWidget with BaseContextHelpers {
  final String? label;
  final List<FileUpload>? certificates;

  const CertificatesView({
    super.key,
    this.label,
    required this.certificates,
  });

  @override
  Widget build(BuildContext context) {
    if (certificates == null || certificates!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "$label:",
              style: TextStyles.bold2(color: AppColors.black),
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: certificates!.map((cert) {
            return InkWell(
              onTap: () {
                navigationService.push(
                  HorizantalPdf(
                    fileUrl: cert.url ?? '',
                    fileName: cert.name ?? '',
                    isfullScreen: true,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.timeBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.picture_as_pdf,
                  size: 40, 
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
