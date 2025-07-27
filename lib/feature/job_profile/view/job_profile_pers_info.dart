import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class JobProfilePersInfo extends StatelessWidget with BaseContextHelpers {
  JobProfilePersInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProfileVM = Provider.of<JobProfileViewModel>(context);

    return SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("Personal Info"),
        const SizedBox(height: 16),

        InputTextField(
          hintText: "Enter Full Name",
          title: "Full Name",
        ),
        const SizedBox(height: 8),

        InputTextField(
          controller: jobProfileVM.mobileNumberController,
          hintText: "Enter Mobile Number",
          title: "Mobile Number",
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter mobile number'
              : null,
        ),
        const SizedBox(height: 8),

        InputTextField(
          controller: jobProfileVM.emailAddressController,
          hintText: "Enter Email Address",
          title: "Email Address",
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter email address'
              : null,
        ),
        const SizedBox(height: 8),

        _buildRoleTypes(jobProfileVM),
        const SizedBox(height: 8),

        _buildEmpTypes(jobProfileVM),
        const SizedBox(height: 8),

        _showEmpTypes(jobProfileVM),
        const SizedBox(height: 8),

        if (jobProfileVM.shouldShowABNField)
          InputTextField(
            controller: jobProfileVM.abnNumberController,
            hintText: "Enter 10-digit ABN Number",
            title: "ABN Number",
            isRequired: true,
            keyboardType: TextInputType.number,
            validator: (value) =>
              value == null || value.isEmpty ?
                'Please enter ABN Number':
                null,
          ),

        const SizedBox(height: 24),
        const Divider(thickness: 4),
        const SizedBox(height: 16),

        _sectionHeader("Basic Info"),
        const SizedBox(height: 16),

        LogoContainer(
          title: "Profile Image",
          imageFile: jobProfileVM.profileFile,
          onTap: () => _imagePickerSelection(
            context,
            () => jobProfileVM.pickProfileImage(ImageSource.gallery),
            () => jobProfileVM.pickProfileImage(ImageSource.camera),
          ),
        ),
        const SizedBox(height: 16),

        InputTextField(
          hintText: "Enter About Yourself",
          maxLength: 500,
          maxLines: 5,
          title: "About Yourself",
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

  void _imagePickerSelection(
    BuildContext context,
    VoidCallback? galleryOnTap,
    VoidCallback? cameraOnTap,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: galleryOnTap,
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: cameraOnTap,
            ),
          ],
        );
      },
    );
  }

  Widget _buildRoleTypes(JobProfileViewModel jobProfileVM) {
    return CustomDropDown(
      value: jobProfileVM.selectedRole,
      title: "Role",
      onChanged: (v) {
       jobProfileVM.setSelectedRole(v as String);
      },
      items: jobProfileVM.roleOptions.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select role type",
      validator: (value) =>
          value == null || value.toString().isEmpty ? 'Please select role type' : null,
    );
  }

  Widget _buildEmpTypes(JobProfileViewModel jobProfileVM) {
    return CustomDropDown(
      value: null,
      title: "Type of employment",
      onChanged: (v) {
        final value = v as String;
        jobProfileVM.addEmploymentTypeChip(value);
      },
      items: jobProfileVM.employmentTypeList
          .map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select employment type",
    );
  }

  Widget _showEmpTypes(JobProfileViewModel jobProfileVM) {
    return Wrap(
      spacing: 6,
      children: jobProfileVM.selectedEmploymentChips.map((e) {
        return Chip(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: AppColors.buttonColor,
          label: Text(
            e,
            style: const TextStyle(color: Colors.white),
          ),
          deleteIcon: const Icon(Icons.close, size: 18, color: Colors.white),
          onDeleted: () {
            jobProfileVM.removeEmploymentTypeChip(e);
          },
        );
      }).toList(),
    );
  }
}
