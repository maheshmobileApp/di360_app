import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_create_view_model.dart';
import 'package:di360_flutter/feature/job_profile/widgets/pdf_picker_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class AddDocumentsDialog extends StatefulWidget with BaseContextHelpers {
  final JobProfileCreateViewModel jobProfileVM;
  const AddDocumentsDialog({Key? key, required this.jobProfileVM})
      : super(key: key);
  @override
  State<AddDocumentsDialog> createState() => _AddDocumentsDialogState();
}

class _AddDocumentsDialogState extends State<AddDocumentsDialog>
    with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final jobProfileVM = widget.jobProfileVM;
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      contentPadding: const EdgeInsets.all(16),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titlePadding: const EdgeInsets.fromLTRB(24, 20, 12, 0),
      title: Row(
        children: [
          Expanded(child: _sectionHeader("Add Documents")),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        height: MediaQuery.of(context).size.height * 0.7,
        child: SingleChildScrollView(
          child: ChangeNotifierProvider<JobProfileCreateViewModel>.value(
            value: jobProfileVM,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<JobProfileCreateViewModel>(
                  builder: (context, vm, _) {
                    return PdfPickerChip(
                      title: "Resume",
                      //isRequired: true,
                      file: vm.resumeFile,
                      serverFileName:  vm.serverDocuments["Resume"]?.name,
                      onTap: () => vm.pickResumePdf(),
                      onRemove: () => vm.removeDocument("Resume"),
                    );
                  },
                ),
                addVertical(16),
                Consumer<JobProfileCreateViewModel>(
                  builder: (context, vm, _) {
                    return PdfPickerChip(
                      title: "Cover Letter",
                      serverFileName:  vm.serverDocuments["Cover Letter"]?.name,
                      file: vm.coverLetterFile,
                      onTap: () => vm.pickCoverLetterPdf(),
                      onRemove: () => vm.removeDocument("Cover Letter"),
                    );
                  },
                ),
                addVertical(16),
                Consumer<JobProfileCreateViewModel>(
                  builder: (context, vm, _) {
                    return PdfPickerChip(
                      title: "Certificate",
                      serverFileName:  vm.serverDocuments["Certificate"]?.name,
                      file: vm.certificateFile,
                      onTap: () => vm.pickCertificatePdf(),
                      onRemove: () => vm.removeDocument("Certificate"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            backgroundColor: AppColors.pendingprimary,
            foregroundColor: AppColors.pendingsendary,
          ),
          child: Text(
            "Cancel",
            style: TextStyles.regular3(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final jobProfileVM = widget.jobProfileVM;
            bool added = false;
            if (jobProfileVM.resumeFile != null) {
              jobProfileVM.addOrUpdateDocument(
                  "Resume", jobProfileVM.resumeFile!);
              added = true;
            }
            if (jobProfileVM.coverLetterFile != null) {
              jobProfileVM.addOrUpdateDocument(
                  "Cover Letter", jobProfileVM.coverLetterFile!);
              added = true;
            }
            if (jobProfileVM.certificateFile != null) {
              jobProfileVM.addOrUpdateDocument(
                  "Certificate", jobProfileVM.certificateFile!);
              added = true;
            }
            /*if (!added) {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.error(
                  message: "Please enter at least one pdf",
                  backgroundColor: AppColors.primaryColor,
                ),
              );
              return;
            }*/
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            foregroundColor: AppColors.whiteColor,
          ),
          child: Text(
            "Save",
            style: TextStyles.regular3(),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }
}
