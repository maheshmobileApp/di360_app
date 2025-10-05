import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsAndConditions extends StatelessWidget with BaseContextHelpers {
  TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    final newCourseVM = Provider.of<NewCourseViewModel>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader("Terms And Conditions"),
              SizedBox(height: 16),
              ImagePickerField(
                title: "Sponsored By",
                isRequired: true,
                serverImages: newCourseVM.serverSponsoredByImg,
                showPreview: true,
                onServerFilesRemoved: (updatedList) {
                  newCourseVM.setServerSponsorImg(updatedList);
                },
                allowMultiple: true,
                selectedFiles: newCourseVM.selectedsponsoredByImg,
                onFilesPicked: (file) => newCourseVM.setSponsoredBy(file),
              ),
              SizedBox(height: 8),
              InputTextField(
                hintText: "Enter Terms & Conditions",
                maxLength: 500,
                maxLines: 5,
                isRequired: true,
                title: "Terms & Conditions",
                controller: newCourseVM.termsAndConditionsController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Terms & Conditions'
                    : null,
              ),
              SizedBox(height: 8),
              InputTextField(
                hintText: "Enter Cancellation & Refund Policy",
                maxLength: 500,
                maxLines: 5,
                isRequired: true,
                title: "Cancellation & Refund Policy",
                controller: newCourseVM.cancellationController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Cancellation & Refund Policy'
                    : null,
              ),
              SizedBox(height: 8),

              /* if (jobCreateVM.showLocumDate) ...[
                SizedBox(
                  height: 8,
                ),
                CustomDatePicker(
                  controller: jobCreateVM.locumDateController,
                  text: null,
                  hintText: "Date",
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      jobCreateVM.locumDateController.text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                  validator: (value) {
                    if (jobCreateVM.showLocumDate &&
                        (value == null || value.isEmpty)) {
                      return "Please select locum date";
                    }
                    return null;
                  },
                ),
                Divider(thickness: 4),
                SizedBox(height: 16),
                _sectionHeader("Job Description"),
                SizedBox(height: 16),
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
              ],*/
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

  Widget _buildCategoryTypes(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: jobCreateVM.selectedRole,
      title: "Category",
      onChanged: (v) {
        jobCreateVM.setSelectedRole(v as String);
      },
      items:
          jobCreateVM.roleOptions.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Category",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select category'
          : null,
    );
  }

  Widget _buildEmpTypes(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: null,
      title: "Type of employment",
      onChanged: (v) {
        final value = v as String;
        jobCreateVM.addEmploymentTypeChip(value);
        jobCreateVM.toggleLocumDateVisibility(value == "Locum");
      },
      items:
          jobCreateVM.empOptions.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select employment type",
      validator: (_) => jobCreateVM.selectedEmploymentChips.isEmpty
          ? 'Please select employment type'
          : null,
    );
  }

  Widget _showEmpTypes(JobCreateViewModel jobCreateVM) {
    return Wrap(
      spacing: 6,
      children: jobCreateVM.selectedEmploymentChips.map((e) {
        return Chip(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: AppColors.secondaryBlueColor,
          label: Text(e),
          deleteIcon: const Icon(Icons.close, size: 18),
          onDeleted: () {
            jobCreateVM.removeEmploymentTypeChip(e);
            if (e == "Locum") {
              jobCreateVM.toggleLocumDateVisibility(false);
              jobCreateVM.locumDateController.clear();
            }
          },
        );
      }).toList(),
    );
  }
}
