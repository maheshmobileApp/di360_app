import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile/model/job_experience.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/job_profile/widgets/custom_selected_fileds.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';



class AddExperienceDialog extends StatefulWidget {
  final JobProfileViewModel jobProfileVM;
  final Experience? experience;
  final int? index;

  const AddExperienceDialog({
    Key? key,
    required this.jobProfileVM,
    this.experience,
    this.index,
  }) : super(key: key);

  @override
  State<AddExperienceDialog> createState() => _AddExperienceDialogState();
}

class _AddExperienceDialogState extends State<AddExperienceDialog>
    with BaseContextHelpers {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final vm = widget.jobProfileVM;
    final exp = widget.experience;
    if (exp != null) {
      vm.jobTitleController.text = exp.jobTitle;
      vm.companyController.text = exp.company;
      vm.descriptionController.text = exp.description;
      vm.selectedStartMonth = exp.startMonth;
      vm.selectedStartYear = exp.startYear;
      vm.selectedEndMonth = exp.endMonth;
      vm.selectedEndYear = exp.endYear;
      vm.isStillWorking = exp.isStillWorking;
    } else {
      vm.jobTitleController.clear();
      vm.companyController.clear();
      vm.descriptionController.clear();
      vm.selectedStartMonth = null;
      vm.selectedStartYear = null;
      vm.selectedEndMonth = null;
      vm.selectedEndYear = null;
      vm.isStillWorking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.jobProfileVM;
    final isEdit = widget.experience != null;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titlePadding: const EdgeInsets.fromLTRB(24, 20, 12, 0),
      title: Row(
        children: [
          Expanded(
              child: _sectionHeader(isEdit ? "Edit Experience" : "Add Experience")),
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
                  controller: vm.jobTitleController,
                  hintText: "Enter Job Title",
                  title: "Job Title",
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Job Title';
                    }
                    return null;
                  },
                ),
                addVertical(16),
                InputTextField(
                  controller: vm.companyController,
                  hintText: "Enter Company Name",
                  title: "Company Name",
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Company Name';
                    }
                    return null;
                  },
                ),
                addVertical(16),
                Text("Started", style: TextStyles.regular3(color: AppColors.black)),
                addVertical(6),
                Row(
                  children: [
                    Expanded(
                      child: CustomSelectField(
                        hint: "Month",
                        value: vm.selectedStartMonth,
                        items: vm.months,
                        onChanged: (v) =>
                            setState(() => vm.selectedStartMonth = v),
                      ),
                    ),
                    addHorizontal(10),
                    Expanded(
                      child: CustomSelectField(
                        hint: "Year",
                        value: vm.selectedStartYear,
                        items: vm.years,
                        onChanged: (v) =>
                            setState(() => vm.selectedStartYear = v),
                      ),
                    ),
                  ],
                ),
                addVertical(16),
                Row(
                  children: [
                    Checkbox(
                      value: vm.isStillWorking,
                      onChanged: (val) {
                        setState(() {
                          vm.isStillWorking = val ?? false;
                          if (vm.isStillWorking) {
                            vm.selectedEndMonth = null;
                            vm.selectedEndYear = null;
                          }
                        });
                      },
                    ),
                    Text("Still Working",
                        style: TextStyles.regular3(color: AppColors.black)),
                  ],
                ),
                addVertical(10),
                Text("Ended", style: TextStyles.regular3(color: AppColors.black)),
                addVertical(6),
                Row(
                  children: [
                    Expanded(
                      child: CustomSelectField(
                        hint: "Month",
                        value: vm.selectedEndMonth,
                        items: vm.months,
                        enabled: !vm.isStillWorking,
                        onChanged: (v) =>
                            setState(() => vm.selectedEndMonth = v),
                      ),
                    ),
                    addHorizontal(10),
                    Expanded(
                      child: CustomSelectField(
                        hint: "Year",
                        value: vm.selectedEndYear,
                        items: vm.years,
                        enabled: !vm.isStillWorking,
                        onChanged: (v) =>
                            setState(() => vm.selectedEndYear = v),
                      ),
                    ),
                  ],
                ),
                addVertical(16),
                InputTextField(
                  controller: vm.descriptionController,
                  hintText: "Enter Job Description",
                  maxLength: 500,
                  maxLines: 4,
                  title: "Job Description",
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
            if (!_formKey.currentState!.validate()) return;

            final jobTitle = vm.jobTitleController.text.trim();
            final company = vm.companyController.text.trim();
            final desc = vm.descriptionController.text.trim();

            final exp = Experience(
              jobTitle: jobTitle,
              company: company,
              description: desc,
              startMonth: vm.selectedStartMonth,
              startYear: vm.selectedStartYear,
              endMonth: vm.selectedEndMonth,
              endYear: vm.selectedEndYear,
              isStillWorking: vm.isStillWorking,
            );

            if (isEdit && widget.index != null) {
              vm.updateExperience(widget.index!, exp);
            } else {
              vm.addExperience(exp);
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
}
