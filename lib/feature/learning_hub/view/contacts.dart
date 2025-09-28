import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contacts extends StatelessWidget with BaseContextHelpers {
  Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<NewCourseViewModel>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader("Contacts"),
              SizedBox(height: 16),
              InputTextField(
                controller: jobCreateVM.nameController,
                hintText: "Enter Name",
                title: "Name",
                isRequired: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter Name' : null,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: jobCreateVM.phoneController,
                hintText: "Enter Phone",
                title: "Phone",
                keyboardType: TextInputType.number,
                maxLength: 10,
                isRequired: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter Phone' : null,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: jobCreateVM.emailController,
                hintText: "Enter Email",
                title: "Email",
                isRequired: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
      
                  // Simple email regex
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid Email';
                  }
      
                  return null;
                },
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: jobCreateVM.websiteUrlController,
                hintText: "Enter Website Url",
                title: "Website Url",
                isRequired: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Website url'
                    : null,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: jobCreateVM.registerLinkController,
                hintText: "Enter Register Link",
                title: "Register Link",
                isRequired: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Register link'
                    : null,
              ),
              SizedBox(height: 8),
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
