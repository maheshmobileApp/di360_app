import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobProfileSkills extends StatelessWidget with BaseContextHelpers {
  JobProfileSkills({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProfileVM = Provider.of<JobProfileViewModel>(context);

    return SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("Skills"),
        const SizedBox(height: 16),

        InputTextField(
          hintText: "Enter Languages Spoken",
          title: "Languages Spoken",
        ),
        const SizedBox(height: 8),

        InputTextField(
          hintText: "Enter Areas of Expertise",
          title: "Areas of Expertise",
        ),
        const SizedBox(height: 8),

        _buildSkills(jobProfileVM),
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

  Widget _buildSkills(JobProfileViewModel  jobProfileVM) {
    return CustomDropDown(
      
      value: jobProfileVM.selectskills,
      title: "Skills",
      onChanged: (v) =>
        jobProfileVM.  setSelectedSkills(v as String)
      ,
      items: jobProfileVM.skillsList.map((value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select skills type",
      
    );
  }


 
}
