import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobProfileProfeInfo extends StatelessWidget with BaseContextHelpers {
  JobProfileProfeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProfileVM = Provider.of<JobProfileViewModel>(context);

    return SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("Professional Info"),
        const SizedBox(height: 16),

        InputTextField(
          hintText: "Enter Job Designation",
          title: "Job Designation",
        ),
        const SizedBox(height: 8),

        InputTextField(
          hintText: "Enter Current Company",
          title: "Current Company",
        ),
        const SizedBox(height: 8),

        _buildWorkRight(jobProfileVM),
        const SizedBox(height: 8),

        _buildExperience(jobProfileVM),
        const SizedBox(height: 8),
      ],
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

  Widget _buildWorkRight(JobProfileViewModel  jobProfileVM) {
    return CustomDropDown(
      
      value: jobProfileVM.selectworkRight,
      title: "Work Rights",
      onChanged: (v) =>
        jobProfileVM. setSelectedWorkRight(v as String),
      items: jobProfileVM.workRightList.map((value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select role type",
      
    );
  }

 Widget _buildExperience(JobProfileViewModel jobProfileVM) {
    return CustomDropDown(
      value: jobProfileVM.selectExperience,
      title: "Experience",
      onChanged: (v) => jobProfileVM.setSelectedExperience(v as String),
      items: jobProfileVM.experienceOptions.map((value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select 0-20",
  
    );
  }

 
}
