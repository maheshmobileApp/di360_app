import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherInfoView extends StatelessWidget with BaseContextHelpers {
  const OtherInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Other info"),
            addVertical(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _checkBox(
                  jobCreateVM.isStartDateEnabled,
                  (val) => jobCreateVM.toggleStartDate(val ?? false),
                  "Start Date",
                ),
                _checkBox(
                  jobCreateVM.isEndDateEnabled,
                  (val) => jobCreateVM.toggleEndDate(val ?? false),
                  "End Date",
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AbsorbPointer(
                    absorbing: !jobCreateVM.isStartDateEnabled,
                    child: CustomDatePicker(
                      controller: TextEditingController(
                        text: jobCreateVM.startDate != null
                            ? "${jobCreateVM.startDate!.day}/${jobCreateVM.startDate!.month}/${jobCreateVM.startDate!.year}"
                            : '',
                      ),
                      onTap: jobCreateVM.isStartDateEnabled
                          ? () => pickAndSetDate(context, jobCreateVM.setStartDate)
                          : null,
                      validator: (_) => jobCreateVM.validateStartDate(
                        jobCreateVM.isStartDateEnabled,
                        jobCreateVM.startDate,
                      ),
                    ),
                  ),
                ),
                addHorizontal(8),
                Expanded(
                  child: AbsorbPointer(
                    absorbing: !jobCreateVM.isEndDateEnabled,
                    child: CustomDatePicker(
                      controller: TextEditingController(
                        text: jobCreateVM.endDate != null
                            ? "${jobCreateVM.endDate!.day}/${jobCreateVM.endDate!.month}/${jobCreateVM.endDate!.year}"
                            : '',
                      ),
                      onTap: jobCreateVM.isEndDateEnabled
                          ? () => pickAndSetDate(context, jobCreateVM.setEndDate)
                          : null,
                      validator: (_) => jobCreateVM.validateEndDate(
                        jobCreateVM.isEndDateEnabled,
                        jobCreateVM.endDate,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            addVertical(16),
            _buildHireData(jobCreateVM),
            addVertical(8),
            _buildPositions(jobCreateVM),
            addVertical(8),
            _buildExperience(jobCreateVM),
            addVertical(8),
            _buildEducation(jobCreateVM),
            addVertical(8),
            _buildBenefits(jobCreateVM),
          ],
        ),
      ),
    );
  }
  Widget _checkBox(bool value, Function(bool?)? onChanged, String text) {
    return Row(
      children: [
        Checkbox(
          visualDensity: VisualDensity.compact,
          value: value,
          onChanged: onChanged,
        ),
        Text(text, style: TextStyles.regular2()),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _buildHireData(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: jobCreateVM.HireList.contains(jobCreateVM.selectHire)
          ? jobCreateVM.selectHire
          : null,
      title: "How quickly to Hire",
      onChanged: (v) => jobCreateVM.setSelectedHireRange(v as String),
      items: jobCreateVM.HireList.toSet().map((value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Eg: immediate, 1 month, etc...",
      validator: (value) =>
          value == null || value.toString().isEmpty ? 'Please select hiring time' : null,
    );
  }

  Widget _buildPositions(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: jobCreateVM.positionsOptions.contains(jobCreateVM.selectPositions)
          ? jobCreateVM.selectPositions
          : null,
      title: "No. of Positions",
      onChanged: (v) => jobCreateVM.setSelectedPositions(v as String),
      items: jobCreateVM.positionsOptions.toSet().map((value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select 0-100",
      validator: (value) =>
          value == null || value.toString().isEmpty ? 'Please select position count' : null,
    );
  }

  Widget _buildExperience(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: jobCreateVM.experienceOptions.contains(jobCreateVM.selectExperience)
          ? jobCreateVM.selectExperience
          : null,
      title: "Experience",
      onChanged: (v) => jobCreateVM.setSelectedExperience(v as String),
      items: jobCreateVM.experienceOptions.toSet().map((value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select 0-20",
      validator: (value) =>
          value == null || value.toString().isEmpty ? 'Please select experience' : null,
    );
  }

  Widget _buildEducation(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
      value: jobCreateVM.educationLevels.contains(jobCreateVM.selectEducation)
          ? jobCreateVM.selectEducation
          : null,
      title: "Education level",
      onChanged: (v) => jobCreateVM.setSelectedEducation(v as String),
      items: jobCreateVM.educationLevels.toSet().map((value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select level",
    );
  }

  Widget _buildBenefits(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
      value: jobCreateVM.Benefits.contains(jobCreateVM.selecteBenefits)
          ? jobCreateVM.selecteBenefits
          : null,
      title: "Do you offer any of the following benefits",
      onChanged: (v) => jobCreateVM.setSelectedBenefits(v as String),
      items: jobCreateVM.Benefits.toSet().map((value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Benefits",
    );
  }
  Future<void> pickAndSetDate(
    BuildContext context,
    void Function(DateTime) setDate,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setDate(picked);
    }
  }
}