import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_profile/model/job_education.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_create_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class AddEducationDialog extends StatefulWidget {
  final JobProfileCreateViewModel jobProfileVM;
  final Education? education;
  final int? index;

  const AddEducationDialog({
    Key? key,
    required this.jobProfileVM,
    this.education,
    this.index,
  }) : super(key: key);

  @override
  State<AddEducationDialog> createState() => _AddEducationDialogState();
}

class _AddEducationDialogState extends State<AddEducationDialog>
    with BaseContextHelpers {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final vm = widget.jobProfileVM;
    final edu = widget.education;
    if (edu != null) {
      vm.QualificationController.text = edu.qualification;
      vm.InstitutionController.text = edu.institution;
      vm.FinishDateController.text = edu.finishDate ?? "";
      vm.ExpectedFinishDateController.text = edu.expectedFinishDate ?? "";
      vm.courseHighlightsController.text = edu.courseHighlights;
      vm.selectedQualification = edu.selectedQualification !=""?edu.selectedQualification : "No";
    } else {
      vm.QualificationController.clear();
      vm.InstitutionController.clear();
      vm.FinishDateController.clear();
      vm.ExpectedFinishDateController.clear();
      vm.courseHighlightsController.clear();
      vm.selectedQualification = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.jobProfileVM;
    final isEdit = widget.education != null;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titlePadding: const EdgeInsets.fromLTRB(24, 20, 12, 0),
      title: Row(
        children: [
          Expanded(child: _sectionHeader(isEdit ? "Edit Education" : "Add Education")),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputTextField(
                  controller: vm.QualificationController,
                  hintText: "Enter Qualification",
                  title: "Qualification",
                  isRequired: true,
                  validator: (v) => v == null || v.isEmpty ? 'Please enter Qualification' : null,
                ),
                addVertical(16),
                InputTextField(
                  controller: vm.InstitutionController,
                  hintText: "Enter Institution",
                  title: "Institution",
                  isRequired: true,
                  validator: (v) => v == null || v.isEmpty ? 'Please enter Institution' : null,
                ),
                addVertical(16),
                _buildQualificationTypes(vm),
                if (vm.selectedQualification == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      'Please select Qualification Finished',
                      style: TextStyle(color: AppColors.primaryColor, fontSize: 12),
                    ),
                  ),
                addVertical(16),
                if (vm.selectedQualification == "Yes") ...[
                  const Text("Finished Date"),
                  CustomDatePicker(
                    controller: vm.FinishDateController,
                    hintText: "Date",
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          vm.FinishDateController.text =
                              "${picked.day}/${picked.month}/${picked.year}";
                        });
                      }
                    },
                  ),
                  if (vm.FinishDateController.text.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Please pick a Finished Date',
                        style: TextStyle(color: Colors.red[700], fontSize: 12),
                      ),
                    ),
                ] else if (vm.selectedQualification == "No") ...[
                  const Text("Expected Finish Date"),
                  CustomDatePicker(
                    controller: vm.ExpectedFinishDateController,
                    hintText: "Date",
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          vm.ExpectedFinishDateController.text =
                              "${picked.day}/${picked.month}/${picked.year}";
                        });
                      }
                    },
                  ),
                  if (vm.ExpectedFinishDateController.text.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Please pick an Expected Finish Date',
                        style: TextStyle(color: Colors.red[700], fontSize: 12),
                      ),
                    ),
                ],
                addVertical(16),
                InputTextField(
                  controller: vm.courseHighlightsController,
                  hintText: "Activities, Awards & etc",
                  maxLength: 500,
                  maxLines: 4,
                  title: "Course Highlights",
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
          child: Text("Cancel", style: TextStyles.regular3()),
        ),
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate() ||
                vm.selectedQualification == null ||
                (vm.selectedQualification == "Yes" && vm.FinishDateController.text.isEmpty) ||
                (vm.selectedQualification == "No" && vm.ExpectedFinishDateController.text.isEmpty)) {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.error(
                  message: "Please complete all required fields",
                  backgroundColor: AppColors.primaryColor,
                ),
              );
              return;
            }

            final edu = Education(
              qualification: vm.QualificationController.text.trim(),
              institution: vm.InstitutionController.text.trim(),
              finishDate: vm.selectedQualification == "Yes"
                  ? vm.FinishDateController.text.trim()
                  : null,
              expectedFinishDate: vm.selectedQualification == "No"
                  ? vm.ExpectedFinishDateController.text.trim()
                  : null,
              selectedQualification: vm.selectedQualification!,
              courseHighlights: vm.courseHighlightsController.text.trim(),
            );

            if (isEdit && widget.index != null) {
              vm.updateEducation(widget.index!, edu);
            } else {
              vm.addEducation(edu);
            }
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            foregroundColor: AppColors.whiteColor,
          ),
          child: Text(isEdit ? "Update" : "Save", style: TextStyles.regular3()),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Text(title, style: TextStyles.clashMedium(color: AppColors.buttonColor));
  }

  Widget _buildQualificationTypes(JobProfileCreateViewModel jobProfileVM) {
    return CustomDropDown(
      value: jobProfileVM.selectedQualification,
      title: "Qualification Finished",
      onChanged: (v) => setState(() {
        jobProfileVM.selectedQualification = v.toString();
      }),
      items: jobProfileVM.QualificationTypes
          .map<DropdownMenuItem<Object>>((String value) =>
              DropdownMenuItem<Object>(value: value, child: Text(value)))
          .toList(),
      hintText: "Select Qualification",
    );
  }
}
