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
import 'package:di360_flutter/feature/learning_hub/widgets/radio_button_group.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CourseInfo extends StatelessWidget with BaseContextHelpers {
  CourseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<NewCourseViewModel>(context);
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Course Info"),
            SizedBox(height: 16),
            CustomRadioGroup<String>(
              title: "Course Event Info",
              isRequired: true,
              options: const ["Single Day", "Multiple Day"],
              selectedValue: jobCreateVM.selectedEvent,
              labelBuilder: (value) => value,
              direction: Axis.vertical, // try Axis.vertical also
              onChanged: (value) {
                jobCreateVM.setSelectedEvent(value);
              },
            ),
            SizedBox(height: 16),
            if (jobCreateVM.selectedEvent == "Single Day") ...[
              _buildSingleDayUI(jobCreateVM, context),
            ] else if (jobCreateVM.selectedEvent == "Multiple Day") ...[
              _buildMultipleDayUI(jobCreateVM, context),
            ],
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
            /*InputTextField(
              controller: jobCreateVM.day1SessionNameController,
              hintText: "Enter Session Name",
              title: "Day 1 Session Name",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter Session name'
                  : null,
            ),
            SizedBox(height: 8),
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
            ImagePickerField(
              title: "Event Image",
              isRequired: true,
              showPreview: true, // show full image
            ),
            SizedBox(height: 8),*/
          ],
        ),
      ),
    );
  }

  /// Single Day Layout
  /// Single Day
  Widget _buildSingleDayUI(
      NewCourseViewModel jobCreateVM, BuildContext context) {
    if (jobCreateVM.sessions.isEmpty) {
      jobCreateVM.addNewDay();
    }
    final day =
        jobCreateVM.sessions.first; 
    return Column(
      children: [
        InputTextField(
          controller: day.sessionNameController,
          hintText: "Enter Session Name",
          title: "Session Name",
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter Session name'
              : null,
        ),
        SizedBox(height: 8),
        CustomDatePicker(
          isRequired: true,
          title: "Event Date",
          controller: day.eventDateController,
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
              day.eventDateController.text =
                  "${picked.day}/${picked.month}/${picked.year}";
            }
          },
          validator: (value) =>
              value == null || value.isEmpty ? 'Please Select Date' : null,
        ),
        SizedBox(height: 8),
        InputTextField(
          controller: day.sessionInfoController,
          hintText: "Enter Information",
          title: "Session Info",
          maxLength: 500,
          maxLines: 5,
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter Session Info'
              : null,
        ),
        SizedBox(height: 8),
        ImagePickerField(
          title: "Event Image",
          isRequired: true,
          showPreview: true,
          allowMultiple: true,
          selectedFiles: day.images,
          onFilesPicked: (files) => jobCreateVM.setEventImgs(0, files),
        ),
      ],
    );
  }

  /// Multiple Day
  Widget _buildMultipleDayUI(
      NewCourseViewModel jobCreateVM, BuildContext context) {
    return Column(
      children: [
        ...jobCreateVM.sessions.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Day ${index + 1}",
                  style: TextStyles.clashMedium(color: AppColors.buttonColor)),
              SizedBox(height: 8),
              InputTextField(
                controller: day.sessionNameController,
                hintText: "Enter Session Name",
                title: "Session Name",
                isRequired: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Session name'
                    : null,
              ),
              SizedBox(height: 8),
              CustomDatePicker(
                isRequired: true,
                title: "Event Date",
                controller: day.eventDateController,
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
                    day.eventDateController.text =
                        "${picked.day}/${picked.month}/${picked.year}";
                  }
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Please Select Date'
                    : null,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: day.sessionInfoController,
                hintText: "Enter Information",
                maxLength: 500,
                maxLines: 5,
                title: "Session Info",
                isRequired: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Session info'
                    : null,
              ),
              SizedBox(height: 8),
              ImagePickerField(
                title: "Event Image",
                isRequired: true,
                allowMultiple: true,
                showPreview: true,
                selectedFiles: day.images,
                onFilesPicked: (files) =>
                    jobCreateVM.setEventImgs(index, files),
              ),
              SizedBox(height: 16),
              if (index > 0)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => jobCreateVM.removeDay(index),
                    child:
                        Text("Remove Day", style: TextStyle(color: Colors.red)),
                  ),
                ),
              Divider(thickness: 1),
            ],
          );
        }).toList(),
        SizedBox(height: 12),
        Align(
          alignment: Alignment.center,
          child: AppButton(
            onTap: () => jobCreateVM.addNewDay(),
            text: "Add Day",
            width: 100.0,
            height: 40.0,
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }
}
