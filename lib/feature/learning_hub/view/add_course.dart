import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCourse extends StatelessWidget with BaseContextHelpers {
  AddCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<NewCourseViewModel>(context);
    

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Add Course"),
            SizedBox(height: 16),
            InputTextField(
              controller: jobCreateVM.courseNameController,
              hintText: "Enter Course Name",
              title: "Course Name",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter Course name'
                  : null,
            ),
            SizedBox(height: 8),
            _buildCategoryTypes(jobCreateVM),
            SizedBox(height: 8),
            _buildCourseTypes(jobCreateVM),
            SizedBox(height: 8),
            CustomDatePicker(
              isRequired: true,
              title: "RSVP Date",
              controller: jobCreateVM.rsvpDateController,
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
                  jobCreateVM.rsvpDateController.text =
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
            SizedBox(height: 8),
            InputTextField(
              controller: jobCreateVM.presenterNameController,
              hintText: "Enter Presenter Name",
              title: "Presented By (Name)",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter Presenter name'
                  : null,
            ),
            SizedBox(height: 8),
            ImagePickerField(
              title: "Presented By (Image)",
              isRequired: true,
              showPreview: true,
              selectedFile: jobCreateVM.selectedPresentedImg, // ✅ comes from ViewModel
              onFilePicked: (file) => jobCreateVM.setPresentedImg(file),
            ),
            SizedBox(height: 8),
            ImagePickerField(
              title: "Course Header Banner / Video",
              isRequired: true,
              allowMultiple: true,
              showPreview: true,
              selectedFiles: jobCreateVM.selectedCourseHeaderBanner, 
              onFilesPicked: (file) => jobCreateVM.setCourseHeaderBaner(file), 
            ),
            SizedBox(height: 8),
            ImagePickerField(
              title: "Gallery",
              isRequired: true,
              allowMultiple: true,
              showPreview: true,
              selectedFiles: jobCreateVM.selectedGallery, 
              onFilesPicked: (file) => jobCreateVM.setGallery(file), 
            ),
            SizedBox(height: 8),
            ImagePickerField(
              title: "Course Banner Image",
              isRequired: true,
              allowMultiple: true,
              showPreview: true,
              selectedFiles: jobCreateVM.selectedCourseBannerImg, 
              onFilesPicked: (file) => jobCreateVM.setCourseBannerImg(file), 
            ),
            SizedBox(height: 8),
            InputTextField(
              hintText: "Enter your text here",
              maxLength: 500,
              maxLines: 5,
              title: "Course Description",
              controller: jobCreateVM.courseDescController,
            ),
            SizedBox(height: 8),
            InputTextField(
              controller: jobCreateVM.cpdPointsController,
              keyboardType: TextInputType.number,
              hintText: "Enter CPD Points",
              title: "CPD Points (Hours)",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter CPD Points'
                  : null,
            ),
            SizedBox(height: 8),
            InputTextField(
              keyboardType: TextInputType.number,
              controller: jobCreateVM.numberOfSeatsController,
              hintText: "Enter number of seats",
              title: "Number of Seats",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter CPD Points'
                  : null,
            ),
            SizedBox(height: 8),
            InputTextField(
              keyboardType: TextInputType.number,
              controller: jobCreateVM.totalPriceController,
              hintText: "Enter Total Price",
              title: "Total Price",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter Total Price'
                  : null,
            ),
            SizedBox(height: 8),
            InputTextField(
              keyboardType: TextInputType.number,
              controller: jobCreateVM.birdPriceController,
              hintText: "Enter Early Bird Price",
              title: "Early Bird Price",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter Bird Price'
                  : null,
            ),
            SizedBox(height: 8),
            CustomDatePicker(
              isRequired: true,
              title: "Early Bird End Date",
              controller: jobCreateVM.earlyBirdDateController,
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
                  jobCreateVM.earlyBirdDateController.text =
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
            SizedBox(height: 8),
            InputTextField(
              hintText: "Enter Description",
              maxLength: 500,
              maxLines: 5,
              title: "Topics Included",
              controller: jobCreateVM.topicsIncludedDescController,
            ),
            SizedBox(height: 8),
            InputTextField(
              hintText: "Enter Description",
              maxLength: 500,
              maxLines: 5,
              title: "Learning Objectives",
              controller: jobCreateVM.learningObjectivesDescController,
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

  Widget _buildCategoryTypes(NewCourseViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: jobCreateVM.selectedCategory,
      title: "Category",
      onChanged: (v) {
        jobCreateVM.setSelectedCategory(v as String);
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

  Widget _buildCourseTypes(NewCourseViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: jobCreateVM.selectedCategory,
      title: "Course Format (Type)",
      onChanged: (v) {
        jobCreateVM.setSelectedCategory(v as String);
      },
      items:
          jobCreateVM.roleOptions.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Course Type",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select Course Type'
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

/*LogoContainer(
              title: "Course Banner Image",
              imageFile: addDirectorVM.logoFile,
              serverImg: addDirectorVM.getBasicInfoData.isNotEmpty
                  ? addDirectorVM.getBasicInfoData.first.logo?.url ?? ''
                  : '',
              onTap: () => imagePickerSelection(
                context,
                () => addDirectorVM.pickLogoImage(ImageSource.gallery),
                () => addDirectorVM.pickLogoImage(ImageSource.camera),
              ),
            ),
 */