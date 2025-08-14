import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorAppoinmentFoam extends StatelessWidget with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
    final teamMemberList = addDirectorVM.teamMemberList.toSet().toList();
    final serviceList = addDirectorVM.serviceList.toSet().toList();
    final daysList = addDirectorVM.DaysList.toSet().toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Add Appointments"),
          addVertical(12),
          CustomDropDown<String>(
            title: 'Select Team Member',
            hintText: 'Select',
            isRequired: true,
            value: teamMemberList.contains(addDirectorVM.selectedTeamMember)
                ? addDirectorVM.selectedTeamMember
                : null,
            items: teamMemberList
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => addDirectorVM.selectedTeamMember = val,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please Select Team Member' : null,
          ),
          addVertical(12),
          CustomDropDown<String>(
            title: 'Services',
            hintText: 'Select',
            isRequired: true,
            value: serviceList.contains(addDirectorVM.selectedTeamService)
                ? addDirectorVM.selectedTeamService
                : null,
            items: serviceList
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => addDirectorVM.selectedTeamService = val,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please Select Service' : null,
          ),
          addVertical(12),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: CustomDropDown<String>(
                  title: 'Select a day',
                  hintText: 'Select',
                  isRequired: true,
                  value: daysList.contains(addDirectorVM.selectedDays)
                      ? addDirectorVM.selectedDays
                      : null,
                  items: daysList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => addDirectorVM.selectedDays = val,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please Select a Day' : null,
                ),
              ),
              addHorizontal(12),
              Flexible(
                flex: 1,
                child: InputTextField(
                  title: "Service Time In Min",
                  hintText: "00:00",
                  readOnly: true,
                  controller: addDirectorVM.SelectServiceTimeminController,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        final now = DateTime.now();
                        final dateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          picked.hour,
                          picked.minute,
                        );
                        addDirectorVM.setServiceTimeDate(dateTime);
                        addDirectorVM.SelectServiceTimeminController.text =
                            picked.format(context);
                      }
                    },
                    child: Icon(Icons.access_time, size: 20),
                  ),
                ),
              ),
            ],
          ),
          addVertical(12),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: InputTextField(
                  title: "Service Start Time",
                  hintText: "00:00",
                  controller: addDirectorVM.SelectServiceStartTimeController,
                  readOnly: true,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        final now = DateTime.now();
                        final dateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          picked.hour,
                        );
                        addDirectorVM.setServiceStartTimeDate(dateTime);
                        addDirectorVM.SelectServiceStartTimeController.text =
                            picked.format(context);
                      }
                    },
                    child: Icon(Icons.access_time, size: 20),
                  ),
                ),
              ),
              addHorizontal(12),
              Flexible(
                flex: 1,
                child: InputTextField(
                  title: "Service End Time",
                  hintText: "00:00",
                  controller: addDirectorVM.SelectServiceEndTimeController,
                  readOnly: true,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        final now = DateTime.now();
                        final dateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          picked.hour,
                        );
                        addDirectorVM.setServiceEndTimeDate(dateTime);
                        addDirectorVM.SelectServiceEndTimeController.text =
                            picked.format(context);
                      }
                    },
                    child: Icon(Icons.access_time, size: 20),
                  ),
                ),
              ),
            ],
          ),

          addVertical(12),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: InputTextField(
                  title: "Break Start Time",
                  hintText: "00:00",
                  controller: addDirectorVM.SelecteBreakStartTimeController,
                  readOnly: true,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        final now = DateTime.now();
                        final dateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          picked.hour,
                        );
                        addDirectorVM.setBreakStartTimeDate(dateTime);
                        addDirectorVM.SelecteBreakStartTimeController.text =
                            picked.format(context);
                      }
                    },
                    child: Icon(Icons.access_time, size: 20),
                  ),
                ),
              ),
              addHorizontal(12),
              Flexible(
                flex: 1,
                child: InputTextField(
                  title: "Break End Time",
                  hintText: "00:00",
                  controller: addDirectorVM.SelectBreakEndTimeController,
                  readOnly: true,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        final now = DateTime.now();
                        final dateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          picked.hour,
                        );
                        addDirectorVM.setBreakEndTimeDate(dateTime);
                        addDirectorVM.SelectBreakEndTimeController.text =
                            picked.format(context);
                      }
                    },
                    child: Icon(Icons.access_time, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }
}
