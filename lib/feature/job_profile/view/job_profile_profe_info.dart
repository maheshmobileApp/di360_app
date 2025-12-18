import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_create_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobProfileProfeInfo extends StatelessWidget with BaseContextHelpers {
  JobProfileProfeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProfileVM = Provider.of<JobProfileCreateViewModel>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader("Professional Info"),
              addVertical(16),
              InputTextField(
                controller: jobProfileVM.jobDesignationController,
                hintText: "Enter Job Designation",
                title: "Job Designation",
                maxLength: 75,
              ),
              addVertical(16),
              InputTextField(
                controller: jobProfileVM.currentCompanyController,
                hintText: "Enter Current Company",
                title: "Current Company",
                maxLength: 75,
              ),
              addVertical(16),
              _buildWorkRight(jobProfileVM),
              addVertical(16),
              _buildExperience(jobProfileVM),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _buildWorkRight(JobProfileCreateViewModel jobProfileVM) {
    final validWorkRight =
        jobProfileVM.workRightList.contains(jobProfileVM.selectworkRight)
            ? jobProfileVM.selectworkRight
            : null;

    return CustomDropDown<String>(
      value: validWorkRight,
      title: "Work Rights",
      onChanged: (v) => jobProfileVM.setSelectedWorkRight(v ?? ""),
      items: jobProfileVM.workRightList.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select role type",
    );
  }

  Widget _buildExperience(JobProfileCreateViewModel jobProfileVM) {
    return CustomDropDown<String>(
      value: jobProfileVM.selectExperience,
      title: "Experience",
      onChanged: (v) => jobProfileVM.setSelectedExperience(v ?? ""),
      items: jobProfileVM.experienceOptions
          .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      hintText: "Select 0-20",
    );
  }
}
