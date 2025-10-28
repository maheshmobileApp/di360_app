import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_multi_select_dropdown.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Job Info"),
            addVertical(16),
            InputTextField(
              controller: jobCreateVM.jobTitleController,
              hintText: "Enter Job Title",
              title: "Job Title",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter job title'
                  : null,
            ),
            addVertical(16),
            InputTextField(
              controller: jobCreateVM.companyNameController,
              readOnly: true,
              hintText: "Enter Company Name",
              title: "Company Name",
            ),
            addVertical(16),
            _buildRoleTypes(jobCreateVM),
            addVertical(16),
            Text(
              "Type of employment ",
              style: TextStyles.regular3(color: AppColors.black),
            ),
            addVertical(4),
            _buildEmpTypes(jobCreateVM),
            addVertical(16),
            if (jobCreateVM.showLocumDate) ...[
              InputTextField(
                controller: jobCreateVM.locumDateController,
                title: "Locum Dates",
                hintText: "Select Locum Dates",
                prefixIcon: const Icon(Icons.calendar_today),
                readOnly: true,
                onTap: () {},
              ),
              addVertical(16),
              Text(
                " Start Locum Dates",
                style: TextStyles.regular3(color: AppColors.black),
              ),
              addVertical(4),
              CustomDatePicker(
                controller: jobCreateVM.startLocumDateController,
                text: "",
                hintText: "Select start date",
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: jobCreateVM.startLocumDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    jobCreateVM.setStartLocumDate(picked);
                  } else {
                    jobCreateVM.clearDates();
                  }
                },
              ),
              addVertical(16),
              Text(
                " End Locum Dates ",
                style: TextStyles.regular3(color: AppColors.black),
              ),
              addVertical(4),
              CustomDatePicker(
                controller: jobCreateVM.endLocumDateController,
                text: "",
                hintText: "Select end date",
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: jobCreateVM.endLocumDate ??
                        jobCreateVM.startLocumDate ??
                        DateTime.now(),
                    firstDate: jobCreateVM.startLocumDate ?? DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    jobCreateVM.setEndLocumDate(picked);
                  } else {
                    jobCreateVM.clearDates();
                  }
                },
              ),
              addVertical(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      jobCreateVM.clearDates();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: const Text("Clear"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      jobCreateVM.updateLocumSummary();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pendingsendary,
                    ),
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
            _sectionHeader("Job Description"),
            addVertical(16),
            InputTextField(
              controller: jobCreateVM.jobDescController,
              hintText: "Enter job description here",
              maxLength: 500,
              maxLines: 5,
              title: "Description",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter job description'
                  : null,
            ),
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
  final validRoles = jobCreateVM.roleOptions;

  final selectedValue = validRoles.contains(jobCreateVM.selectedRole)
      ? jobCreateVM.selectedRole
      : null;

  return CustomDropDown(
    isRequired: true,
    value: selectedValue,
    title: "Role",
    onChanged: (v) {
      jobCreateVM.setSelectedRole(v as String);
    },
    items: validRoles.map<DropdownMenuItem<Object>>((String value) {
      return DropdownMenuItem<Object>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    hintText: "Select role type",
    validator: (value) => value == null || value.toString().isEmpty
        ? 'Please select role type'
        : null,
  );
}


  Widget _buildEmpTypes(JobCreateViewModel jobCreateVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomMultiSelectDropDown<String>(
          items: jobCreateVM.empOptions,
          selectedItems: jobCreateVM.selectedEmploymentChips,
          itemLabel: (item) => item,
          hintText: "Select employment type",
          onSelectionChanged: (selected) {
            final current =
                List<String>.from(jobCreateVM.selectedEmploymentChips);
            for (final emp in current) {
              if (!selected.contains(emp)) {
                jobCreateVM.removeEmploymentTypeChip(emp);
              }
            }
            for (final emp in selected) {
              if (!current.contains(emp)) {
                jobCreateVM.addEmploymentTypeChip(emp);
              }
            }
          },
        ),
        addVertical(16),
        _showEmpTypes(jobCreateVM),
      ],
    );
  }

  Widget _showEmpTypes(JobCreateViewModel jobCreateVM) {
    return Wrap(
      spacing: 6,
      children: jobCreateVM.selectedEmploymentChips.map((e) {
        return Chip(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          backgroundColor: AppColors.secondaryBlueColor,
          label: Text(e),
          deleteIcon: const Icon(Icons.close, size: 18),
          onDeleted: () => jobCreateVM.removeEmploymentTypeChip(e),
        );
      }).toList(),
    );
  }
}
