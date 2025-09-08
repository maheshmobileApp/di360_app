import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/add_directors/model/certificate_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class AddDirectoryCertificateCard extends StatelessWidget {
  final String title;
  final File? imageFile;
  final VoidCallback onDelete;
  final CertificateModel certificate;
  final int index;

  const AddDirectoryCertificateCard({
    super.key,
    required this.title,
    this.imageFile,
    required this.onDelete,
    required this.certificate,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          if (imageFile != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.file(
                imageFile!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          // const SizedBox(width: 10),
          // GestureDetector(
          //   onTap: () {
          //     showCertificatesOptionsBottomSheet(context, certificate, index);
          //   },
          //   child: const Icon(Icons.more_vert, size: 20),
          // ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(
              Icons.delete_outline,
              color: AppColors.redColor,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  void showCertificatesOptionsBottomSheet(
      BuildContext context, CertificateModel certificate, int index) {
    final addDirectorVM =
        Provider.of<AddDirectorViewModel>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.8,
          minChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.buttomBarColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.buttomBarColor,
                            backgroundImage: certificate.imageFile != null
                                ? FileImage(certificate.imageFile!)
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  certificate.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CustomBottomButton(
                      onFirst: () {
                        addDirectorVM.certificateList.remove(certificate);
                        addDirectorVM;
                        Navigator.pop(context);
                      },
                      onSecond: () {
                        Navigator.pop(context);
                        showEditCertificatesBottomSheet(
                            context, certificate, index);
                      },
                      firstLabel: "Delete",
                      secondLabel: "Edit",
                      firstBgColor: AppColors.timeBgColor,
                      firstTextColor: AppColors.primaryColor,
                      secondBgColor: AppColors.primaryColor,
                      secondTextColor: AppColors.whiteColor,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showEditCertificatesBottomSheet(
      BuildContext context, CertificateModel certificate, int index) {
    final addDirectorVM =
        Provider.of<AddDirectorViewModel>(context, listen: false);

    addDirectorVM.selectedCertificate = certificate;
    addDirectorVM.loadCertificatesData(certificate);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.buttomBarColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller:
                                  addDirectorVM.certificateNameController,
                              decoration: const InputDecoration(
                                labelText: "Certificate Name",
                              ),
                            ),
                            const SizedBox(height: 20),
                            // image picker widget
                            if (addDirectorVM.certificateFile != null)
                              Image.file(
                                addDirectorVM.certificateFile!,
                                height: 100,
                              ),
                          ],
                        ),
                      ),
                    ),
                    CustomBottomButton(
                      onFirst: () {
                        addDirectorVM.certificateList.remove(certificate);
                        addDirectorVM;
                        Navigator.pop(context);
                      },
                      onSecond: () {
                        addDirectorVM.updateCertificates(index);
                        Navigator.pop(context);
                      },
                      firstLabel: "Delete",
                      secondLabel: "Save",
                      firstBgColor: AppColors.timeBgColor,
                      firstTextColor: AppColors.primaryColor,
                      secondBgColor: AppColors.primaryColor,
                      secondTextColor: AppColors.whiteColor,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
