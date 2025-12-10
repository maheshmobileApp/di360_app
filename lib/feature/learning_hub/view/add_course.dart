import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_time_picker.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddCourse extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  AddCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<NewCourseViewModel>(context);
    final type = jobCreateVM.selectedCourseType;
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
              _buildCourseTypes(jobCreateVM),
              SizedBox(height: 8),
              _buildCategoryTypes(jobCreateVM),
              SizedBox(height: 8),
              InputTextField(
                controller: jobCreateVM.courseNameController,
                hintText: "Enter Course Name",
                title: "Course Name",
                maxLength: 100,
                isRequired: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Course name'
                    : null,
              ),
              SizedBox(height: 8),
              if (showStartEndDate) ...[
                CustomDatePicker(
                  isRequired: true,
                  title: "Start Date",
                  controller: jobCreateVM.startDateController,
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
                      jobCreateVM.startDateController.text =
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
                  controller: jobCreateVM.endDateController,
                  text: null,
                  hintText: "Date",
                  onTap: () async {
                    DateTime startDate =
                        jobCreateVM.startDateController.text.isNotEmpty
                            ? DateFormat("dd/MM/yyyy")
                                .parse(jobCreateVM.startDateController.text)
                            : DateTime.now();

                    final picked = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate:
                          startDate, // 👈 End date cannot be before start date
                      lastDate: DateTime(2100),
                    );

                    if (picked != null) {
                      jobCreateVM.endDateController.text =
                          DateFormat("dd/MM/yyyy").format(picked);
                    }
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please Select Date'
                      : null,
                ),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  Expanded(
                    child: CustomTimePicker(
                      controller: jobCreateVM.startTimeController,
                      title: "Start Time",
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select Start Time';
                        }

                        final selectedDateText =
                            jobCreateVM.startDateController.text;
                        if (selectedDateText.isEmpty) {
                          return null; // Date not selected yet
                        }

                        // ---- Parse date in dd/MM/yyyy format ----
                        DateTime? selectedDate;
                        try {
                          selectedDate =
                              DateFormat('dd/MM/yyyy').parse(selectedDateText);
                        } catch (_) {
                          return "Invalid date format";
                        }

                        final now = DateTime.now();

                        bool isToday = selectedDate.year == now.year &&
                            selectedDate.month == now.month &&
                            selectedDate.day == now.day;

                        if (isToday) {
                          // Parse time (AM/PM or 24h)
                          final parsedTime = _parseTime(value);

                          final selectedDateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            parsedTime.hour,
                            parsedTime.minute,
                          );

                          if (selectedDateTime.isBefore(now)) {
                            return 'Start time cannot be in the past';
                          }
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTimePicker(
                      controller: jobCreateVM.endTimeController,
                      title: "End Time",
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please Select End Time';
                        if (jobCreateVM.startTimeController.text.isNotEmpty &&
                            !isEndTimeAfterStartTime(
                                jobCreateVM.startTimeController.text, value)) {
                          return 'End Time must be later than Start Time';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (showAddress) ...[
                InputTextField(
                  controller: jobCreateVM.addressController,
                  hintText: "Enter Address",
                  title: "Address",
                  isRequired: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Address'
                      : null,
                ),
              ],
              /*SizedBox(height: 8),
              CustomDatePicker(
                title: "RSVP Date",
                controller: jobCreateVM.rsvpDateController,
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
                    jobCreateVM.rsvpDateController.text =
                        "${picked.day}/${picked.month}/${picked.year}";
                  }
                },
              ),*/
              SizedBox(height: 8),
              InputTextField(
                controller: jobCreateVM.presenterNameController,
                hintText: "Enter Presenter Name",
                title: "Presented By (Name)",
                maxLength: 75,
                isRequired: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Presenter name'
                    : null,
              ),
              SizedBox(height: 8),
              ImagePickerField(
                title: "Presented By (Image)",
                isRequired: true,
                serverImage: jobCreateVM.serverPresentedImg,
                serverImageType: "image",
                onServerFileRemoved: (value) {
                  jobCreateVM.setPresentedImg(null);
                },
                showPreview: true,
                selectedFile: jobCreateVM.selectedPresentedImg,
                onFilePicked: (file) => jobCreateVM.setPresentedImg(file),
              ),
              SizedBox(height: 8),
              _sectionHeader("Images/Video"),
              SizedBox(height: 8),
              ImagePickerField(
                title: "Course Header Banner / Video",
                isRequired: true,
                serverImage: jobCreateVM.serverCourseHeaderBanner?.url,
                serverImageType: jobCreateVM.serverCourseHeaderBanner?.type,
                showPreview: true,
                onServerFileRemoved: (value) {
                  jobCreateVM.setCourseHeaderBaner(null);
                },
                selectedFile: jobCreateVM.selectedCourseHeaderBanner,
                onFilePicked: (file) => jobCreateVM.setCourseHeaderBaner(file),
              ),
              SizedBox(height: 8),
              
              ImagePickerField(
                title: "Gallery",
                isRequired: true,
                serverImages: jobCreateVM.serverGallery,
                allowMultiple: true,
                onServerFilesRemoved: (updatedList) {
                  jobCreateVM.setServerGallery(updatedList);
                },
                showPreview: true,
                selectedFiles: jobCreateVM.selectedGallery,
                onFilesPicked: (file) => jobCreateVM.setGallery(file),
              ),
              SizedBox(height: 8),
              ImagePickerField(
                title: "Course Header Banner Image",
                isRequired: true,
                allowMultiple: true,
                serverImages: jobCreateVM.serverCourseBannerImg,
                showPreview: true,
                onServerFilesRemoved: (updatedList) {
                  jobCreateVM.setServerCourseBannerImg(updatedList);
                },
                selectedFiles: jobCreateVM.selectedCourseBannerImg,
                onFilesPicked: (file) => jobCreateVM.setCourseBannerImg(file),
              ),
              SizedBox(height: 8),
              _sectionHeader("Price/Availability"),
              SizedBox(height: 8),
              InputTextField(
                hintText: "Enter your text here",
                maxLength: 1000,
                maxLines: 5,
                isRequired: true,
                title: "Course Description",
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Course Description'
                    : null,
                controller: jobCreateVM.courseDescController,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: jobCreateVM.cpdPointsController,
                keyboardType: TextInputType.number,
                hintText: "Enter CPD Points",
                maxLength: 4,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Bird Price';
                    }

                    if (value == '0') {
                      return 'Number of seats cannot be zero';
                    }
                    return null;
                  }),
              SizedBox(height: 8),
              InputTextField(
                  keyboardType: TextInputType.number,
                  controller: jobCreateVM.totalPriceController,
                  hintText: "Enter Total Price",
                  title: "Total Price",
                  isRequired: true,
                  validator: validatePositiveNumber),
              SizedBox(height: 8),
              InputTextField(
                keyboardType: TextInputType.number,
                controller: jobCreateVM.birdPriceController,
                hintText: "Enter Early Bird Price",
                title: "Early Bird Price",
                isRequired: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]*\.?[0-9]*$')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Bird Price';
                  }

                  final birdPrice = double.tryParse(value) ?? -1;
                  if (birdPrice < 0) {
                    return 'Bird Price cannot be negative';
                  }

                  final totalPrice =
                      double.tryParse(jobCreateVM.totalPriceController.text) ??
                          0;

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
                controller: jobCreateVM.earlyBirdDateController,
                text: null,
                hintText: "Date",
                onTap: () async {
                  DateTime startDate =
                      jobCreateVM.startDateController.text.isNotEmpty
                          ? DateFormat("dd/MM/yyyy")
                              .parse(jobCreateVM.startDateController.text)
                          : DateTime.now();
                  DateTime endDate =
                      jobCreateVM.endDateController.text.isNotEmpty
                          ? DateFormat("dd/MM/yyyy")
                              .parse(jobCreateVM.endDateController.text)
                          : DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: startDate,
                    lastDate: endDate,
                  );
                  if (picked != null) {
                    jobCreateVM.earlyBirdDateController.text =
                        "${picked.day}/${picked.month}/${picked.year}";
                  }
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Please Select Date'
                    : null,
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

  TimeOfDay _parseTime(String timeString) {
    try {
      // Tries to parse AM/PM format
      final dt = DateFormat("hh:mm a").parse(timeString);
      return TimeOfDay.fromDateTime(dt);
    } catch (_) {
      // Fallback for 24-hour format
      final parts = timeString.split(":");
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }
  }

  Widget _buildCourseTypes(NewCourseViewModel jobCreateVM) {
    // Remove duplicates and sanitize data
    final courseTypeList = jobCreateVM.courseTypeNames.toSet().toList();

    // Ensure the selected value actually exists
    final safeSelectedType =
        courseTypeList.contains(jobCreateVM.selectedCourseType)
            ? jobCreateVM.selectedCourseType
            : null;

    return CustomDropDown(
      isRequired: true,
      value: safeSelectedType, // ✅ safe value
      title: "Course Format (Type)",
      onChanged: (v) {
        jobCreateVM.setSelectedCourseType(v as String);
      },
      items: courseTypeList.map<DropdownMenuItem<Object>>((String value) {
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

  DateTime? parseTime(String timeString) {
    try {
      // Try 24-hour format first: "HH:mm"
      final parts = timeString.split(':');
      if (parts.length == 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(
            parts[1].replaceAll(RegExp(r'[^0-9]'), '')); // remove AM/PM if any

        // If time has AM/PM
        if (timeString.toLowerCase().contains('pm') && hour < 12) hour += 12;
        if (timeString.toLowerCase().contains('am') && hour == 12) hour = 0;

        return DateTime(0, 1, 1, hour, minute);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  bool isEndTimeAfterStartTime(String startTime, String endTime) {
    final start = parseTime(startTime);
    final end = parseTime(endTime);

    if (start == null || end == null) return false;

    return end.isAfter(start);
  }
}
