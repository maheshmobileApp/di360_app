import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobInfo extends StatelessWidget with BaseContextHelpers {
  JobInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Job Info"),
            SizedBox(
              height: 16,
            ),
            InputTextField(
              hintText: "Enter Job Title",
              title: "Job Title",
              isRequired: true,
            ),
            SizedBox(
              height: 8,
            ),
            InputTextField(
              hintText: "Enter Job Title",
              title: "Company Name",
              isRequired: true,
            ),
            SizedBox(
              height: 8,
            ),
            _buildRoleTypes(jobCreateVM),
            SizedBox(
              height: 8,
            ),
            _buildEmpTypes(jobCreateVM),
            SizedBox(
              height: 8,
            ),
            _showEmpTypes(jobCreateVM),
            Divider(
              thickness: 4,
            ),
            SizedBox(
              height: 16,
            ),
            _sectionHeader("Job Description"),
            SizedBox(
              height: 16,
            ),
            InputTextField(
              hintText: "Enter your title here",
              maxLength: 500,
             maxLines: 5,
              title: "Description")
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

  Widget _buildRoleTypes(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
        isRequired: true,
        value: jobCreateVM.selectedRole,
        title: "Role",
        onChanged: (v) {
          jobCreateVM.setSelectedRole(v as String);
        },
        items: jobCreateVM.roleOptions
            .map<DropdownMenuItem<Object>>((String value) {
          return DropdownMenuItem<Object>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hintText: "Select role type");
  }

  Widget _buildEmpTypes(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
        isRequired: true,
        value: jobCreateVM.selectedEmploymentType,
        title: "Type of employment *",
        onChanged: (v) {
          jobCreateVM.addEmploymentTypeChip(v as String);
        },
        items:
            jobCreateVM.empOptions.map<DropdownMenuItem<Object>>((String value) {
          return DropdownMenuItem<Object>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hintText: "Select Employment type ");
  }

  Widget _showEmpTypes(JobCreateViewModel jobCreateVM) {
    return Wrap(
      spacing: 6,
      children: jobCreateVM.selectedEmploymentChips.map((e) {
        return Chip(
            padding: EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            backgroundColor: AppColors.secondaryBlueColor,
            label: Text(e),
            deleteIcon: Icon(Icons.close, size: 18),
            onDeleted: () {
              jobCreateVM.removeEmploymentTypeChip(e);
            });
      }).toList(),
    );
  }
}
