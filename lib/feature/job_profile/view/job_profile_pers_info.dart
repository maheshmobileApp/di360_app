import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/reg_exp.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_multi_select_dropdown.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_create_view_model.dart';
import 'package:di360_flutter/feature/job_profile/widgets/custom_selected_fileds.dart';

import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class JobProfilePersInfo extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  JobProfilePersInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProfileVM = Provider.of<JobProfileCreateViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader("Personal Info"),
                      addVertical(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Post as Anonymous",
                            style: TextStyles.regular3(color: AppColors.black),
                          ),
                          _customToggleButton(jobProfileVM),
                        ],
                      ),
                      addVertical(16),
                      InputTextField(
                        controller: jobProfileVM.fullNameController,
                        readOnly: true,
                        hintText: "Enter Full Name",
                        title: "Full Name",
                      ),
                      addVertical(16),
                      InputTextField(
                        controller: jobProfileVM.mobileNumberController,
                        hintText: "Enter Mobile Number",
                        title: "Mobile Number",
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        isRequired: true,
                        validator: validatePhoneNumber,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      addVertical(16),
                      InputTextField(
                        controller: jobProfileVM.emailAddressController,
                        hintText: "Enter Email Address",
                        title: "Email Address",
                        isRequired: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email address';
                          }
                          if (!checkEmailValidation(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      addVertical(16),
                      _buildRoleTypes(jobProfileVM),
                      addVertical(16),
                      Text(
                        "Work Type",
                        style: TextStyles.regular3(color: AppColors.black),
                      ),
                      addVertical(4),
                      _buildEmpTypes(jobProfileVM),
                      addVertical(16),
                      _sectionHeader("Basic Info"),
                      /*LogoContainer(
                title: "Profile Image",
                imageFile: jobProfileVM.profileFile,
                onTap: () => _imagePickerSelection(
                  context,
                  () => jobProfileVM.pickProfileImage(ImageSource.gallery),
                  () => jobProfileVM.pickProfileImage(ImageSource.camera),
                ),
              ),*/
                      ImagePickerField(
                        title: "Profile Image",
                        isRequired: true,
                        serverImage: jobProfileVM.serverProfileFile,
                        serverImageType: "image",
                        onServerFileRemoved: (value) {
                          jobProfileVM.setProfileImg(null);
                        },
                        showPreview: true,
                        selectedFile: jobProfileVM.profileFile,
                        onFilePicked: (file) =>
                            jobProfileVM.setProfileImg(file),
                      ),
                      addVertical(16),
                      InputTextField(
                        controller: jobProfileVM.aboutMeController,
                        hintText: "Enter About Yourself",
                        maxLength: 500,
                        maxLines: 5,
                        title: "About Yourself",
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _customToggleButton(JobProfileCreateViewModel jobProfileVM) {
    return GestureDetector(
      onTap: () => jobProfileVM.togglePostAnonymous(!jobProfileVM.isPostAnonymous),
      child: Container(
        width: 50,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: jobProfileVM.isPostAnonymous 
              ? AppColors.primaryColor 
              : AppColors.geryColor,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: jobProfileVM.isPostAnonymous 
              ? Alignment.centerRight 
              : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
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



  Widget _buildRoleTypes(JobProfileCreateViewModel jobProfileVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropDown(
          value: jobProfileVM.selectedRole,
          title: "Role",
          onChanged: (v) {
            jobProfileVM.setSelectedRole(v as String);
          },
          items: jobProfileVM.roleOptions
              .map<DropdownMenuItem<Object>>((String value) {
            return DropdownMenuItem<Object>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hintText: "Select role type",
          validator: (value) => value == null || value.toString().isEmpty
              ? 'Please select role type'
              : null,
        ),
      ],
    );
  }

  Widget _buildEmpTypes(JobProfileCreateViewModel jobProfileVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomMultiSelectDropDown<String>(
          items: jobProfileVM.employmentTypeList,
          selectedItems: jobProfileVM.selectedEmploymentChips,
          itemLabel: (item) => item,
          hintText: "Select employment type",
          onSelectionChanged: (selected) {
            jobProfileVM.setSelectedEmploymentTypes(selected);
          },
        ),
        addVertical(8),
        _showEmpTypes(jobProfileVM),
        if (jobProfileVM.shouldShowABNField) ...[
          addVertical(8),
          InputTextField(
            controller: jobProfileVM.abnNumberController,
            hintText: "Enter 10-digit ABN Number",
            title: "ABN Number",
            maxLength: 10,
            isRequired: true,
            keyboardType: TextInputType.number,
            validator: validateABNNumber,
          ),
        ],
        if (jobProfileVM.selectedRole == "Dentist" ||
            jobProfileVM.selectedRole == "Dental Specialist") ...[
          addVertical(8),
          InputTextField(
            controller: jobProfileVM.aphraRegistrationNumberController,
            hintText: "Enter 10-digit Aphra Registration Number",
            title: "Aphra Registration Number",
            isRequired: true,
            maxLength: 13,
            validator: validateAphraNumber,
          ),
        ],
        if ((jobProfileVM.selectedRole == "Dentist" ||
                jobProfileVM.selectedRole == "Dental Hygienist") &&
            (jobProfileVM.selectedEmploymentChips.contains("Locum") ||
                jobProfileVM.selectedEmploymentChips
                    .contains("Contractor"))) ...[
          addVertical(8),
          InputTextField(
            controller: jobProfileVM.percentageController,
            hintText: "Enter %",
            title: "Percentage (%)",
            maxLength: 3,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ],
        if ((jobProfileVM.selectedRole == "Dentist" ||
                jobProfileVM.selectedRole == "Dental Hygienist") &&
            (jobProfileVM.selectedEmploymentChips.contains("Casual") ||
                jobProfileVM.selectedEmploymentChips.contains("Full Time") ||
                jobProfileVM.selectedEmploymentChips
                    .contains("Part Time"))) ...[
          addVertical(8),
          //Text("Salary", style: TextStyles.regular3(color: AppColors.black)),
          //addVertical(6),
          Row(
            children: [
              Expanded(
                child: InputTextField(
                  controller: jobProfileVM.salaryController,
                  hintText: "Enter Amount",
                  title: "Salary",
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              addHorizontal(10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: CustomSelectField(
                    hint: "Per",
                    value: jobProfileVM.selectedSalaryPer,
                    items: jobProfileVM.salaryPerOptions,
                    onChanged: (v) {
                      jobProfileVM.setSelectSalaryPer(v);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _showEmpTypes(JobProfileCreateViewModel jobProfileVM) {
    return Wrap(
      spacing: 6,
      children: jobProfileVM.selectedEmploymentChips.map((e) {
        return Chip(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          backgroundColor: AppColors.secondaryBlueColor,
          label: Text(e),
          deleteIcon: const Icon(Icons.close, size: 18),
          onDeleted: () {
            jobProfileVM.removeEmploymentTypeChip(e);
          },
        );
      }).toList(),
    );
  }
}
