import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_time_picker.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddCourse extends StatelessWidget with BaseContextHelpers {
  AddCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final newCourseVM = Provider.of<NewCourseViewModel>(context);
    final type = newCourseVM.selectedCourseType;
    final showStartEndDate = [
      "Event",
      "Webinar",
      "Live Course",
      "Live Event",
      "Test"
    ].contains(type);

    final showAddress = ["Event", "Live Course", "Live Event"].contains(type);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader("Add Course"),
              SizedBox(height: 16),
              _buildCourseTypes(newCourseVM),
              SizedBox(height: 8),
              _buildCategoryTypes(newCourseVM),
              SizedBox(height: 8),
              InputTextField(
                controller: newCourseVM.courseNameController,
                hintText: "Enter Course Name",
                title: "Course Name",
                isRequired: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Course name'
                    : null,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CustomTimePicker(
                      controller: newCourseVM.startTimeController,
                      title: "Start Time",
                      isRequired: true,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please Select Time'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12), // spacing between fields
                  Expanded(
                    child: CustomTimePicker(
                      controller: newCourseVM.endTimeController,
                      title: "End Time",
                      isRequired: true,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please Select Time'
                          : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (showStartEndDate) ...[
                CustomDatePicker(
                  isRequired: true,
                  title: "Start Date",
                  controller: newCourseVM.startDateController,
                  text: null,
                  hintText: "Date",
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      newCourseVM.startDateController.text =
                          DateFormat("dd/MM/yyyy").format(picked);
                    }
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please Select Date'
                      : null,
                ),
                const SizedBox(height: 8),
                CustomDatePicker(
                  isRequired: true,
                  title: "End Date",
                  controller: newCourseVM.endDateController,
                  text: null,
                  hintText: "Date",
                  onTap: () async {
                    DateTime startDate =
                        newCourseVM.startDateController.text.isNotEmpty
                            ? DateFormat("dd/MM/yyyy")
                                .parse(newCourseVM.startDateController.text)
                            : DateTime.now();
      
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate:
                          startDate, // 👈 End date cannot be before start date
                      lastDate: DateTime(2100),
                    );
      
                    if (picked != null) {
                      newCourseVM.endDateController.text =
                          DateFormat("dd/MM/yyyy").format(picked);
                    }
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please Select Date'
                      : null,
                ),
                const SizedBox(height: 8),
              ],
              if (showAddress) ...[
                InputTextField(
                  controller: newCourseVM.addressController,
                  hintText: "Enter Address",
                  title: "Address",
                  isRequired: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Address'
                      : null,
                ),
              ],
              SizedBox(height: 8),
              CustomDatePicker(
                isRequired: true,
                title: "RSVP Date",
                controller: newCourseVM.rsvpDateController,
                text: null,
                hintText: "Date",
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    newCourseVM.rsvpDateController.text =
                        "${picked.day}/${picked.month}/${picked.year}";
                  }
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please Select Date' : null,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: newCourseVM.presenterNameController,
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
                serverImage: newCourseVM.serverPresentedImg,
                showPreview: true,
                selectedFile: newCourseVM.selectedPresentedImg,
                onFilePicked: (file) => newCourseVM.setPresentedImg(file),
              ),
              SizedBox(height: 8),
              _sectionHeader("Images/Video"),
              SizedBox(height: 8),
              ImagePickerField(
                title: "Course Header Banner / Video",
                isRequired: true,
                serverImage: newCourseVM.serverCourseHeaderBanner,
                showPreview: true,
                selectedFile: newCourseVM.selectedCourseHeaderBanner,
                onFilePicked: (file) => newCourseVM.setCourseHeaderBaner(file),
              ),
              SizedBox(height: 8),
              ImagePickerField(
                title: "Gallery",
                isRequired: true,
                allowMultiple: true,
                serverImages: newCourseVM.serverGallery,
                showPreview: true,
                selectedFiles: newCourseVM.selectedGallery,
                onFilesPicked: (file) => newCourseVM.setGallery(file),
              ),
              SizedBox(height: 8),
              ImagePickerField(
                title: "Course Header Banner Image",
                isRequired: true,
                allowMultiple: true,
                serverImages: newCourseVM.serverCourseBannerImg,
                showPreview: true,
                selectedFiles: newCourseVM.selectedCourseBannerImg,
                onFilesPicked: (file) => newCourseVM.setCourseBannerImg(file),
              ),
              SizedBox(height: 8),
              _sectionHeader("Price/Availability"),
              SizedBox(height: 8),
              InputTextField(
                hintText: "Enter your text here",
                maxLength: 500,
                maxLines: 5,
                isRequired: true,
                title: "Course Description",
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Course Description'
                    : null,
                controller: newCourseVM.courseDescController,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: newCourseVM.cpdPointsController,
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
                controller: newCourseVM.numberOfSeatsController,
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
                controller: newCourseVM.totalPriceController,
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
                controller: newCourseVM.birdPriceController,
                hintText: "Enter Early Bird Price",
                title: "Early Bird Price",
                isRequired: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Bird Price';
                  }
      
                  final birdPrice = double.tryParse(value) ?? 0;
                  final totalPrice =
                      double.tryParse(newCourseVM.totalPriceController.text) ?? 0;
      
                  if (birdPrice > totalPrice) {
                    return 'Bird Price cannot be more than Total Price';
                  }
      
                  return null;
                },
              ),
              SizedBox(height: 8),
              CustomDatePicker(
                isRequired: true,
                title: "Early Bird End Date",
                controller: newCourseVM.earlyBirdDateController,
                text: null,
                hintText: "Date",
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    newCourseVM.earlyBirdDateController.text =
                        "${picked.day}/${picked.month}/${picked.year}";
                  }
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please Select Date' : null,
              ),
              SizedBox(height: 8),
              /*
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
              ),*/
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

  Widget _buildCategoryTypes(NewCourseViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: jobCreateVM.selectedCategory,
      title: "Category",
      onChanged: (v) {
        jobCreateVM.setSelectedCourseCategory(v as String);
      },
      items: jobCreateVM.courseCategory
          .map<DropdownMenuItem<Object>>((String value) {
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
      value: jobCreateVM.selectedCourseType,
      title: "Course Format (Type)",
      onChanged: (v) {
        jobCreateVM.setSelectedCourseType(v as String);
      },
      items: jobCreateVM.courseTypeNames
          .map<DropdownMenuItem<Object>>((String value) {
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
}
