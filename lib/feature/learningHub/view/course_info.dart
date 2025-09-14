import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:di360_flutter/feature/learningHub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CourseInfo extends StatelessWidget with BaseContextHelpers {
  CourseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<NewCourseViewModel>(context);
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Course Info"),
            SizedBox(height: 16),
            InputTextField(
              controller: jobCreateVM.day1SessionNameController,
              hintText: "Enter Session Name",
              title: "Day 1 Session Name",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter Session name'
                  : null,
            ),
            InputTextField(
              controller: jobCreateVM.sessioInfoController,
              hintText: "Enter Information",
              title: "Session Info",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter Session Info'
                  : null,
            ),
            SizedBox(height: 8),
            LogoContainer(
              title: "Event Image",
              imageFile: null,
              serverImg: null,
              onTap: () => imagePickerSelection(
                context,
                () => addDirectorVM.pickLogoImage(ImageSource.gallery),
                () => addDirectorVM.pickLogoImage(ImageSource.camera),
              ),
            ),
            SizedBox(height: 8),
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
