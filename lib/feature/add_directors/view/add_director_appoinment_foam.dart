import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorAppoinmentFoam extends StatelessWidget
    with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final teamMemberList =
        addDirectorVM.getBasicInfoData.first.directoryTeamMembers;
    final serviceList = addDirectorVM.getBasicInfoData.first.directoryServices;
    final daysList = ConstantData.DaysList.toSet().toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader("Add Appointments"),
          addVertical(12),
          CustomDropDown<String>(
            title: 'Select Team Member',
            hintText: 'Select',
            isRequired: true,
            value: addDirectorVM.selectedTeamMember?.id,
            items: teamMemberList
                    ?.map((e) => DropdownMenuItem<String>(
                          value: e.id,
                          child: Text(e.name ?? ''),
                        ))
                    .toList() ??
                [],
            onChanged: (val) {
              if (val != null) {
                final member = teamMemberList?.firstWhere((m) => m.id == val);
                addDirectorVM.selectedTeamMember = member;
              }
            },
            validator: (value) => value == null || value.isEmpty
                ? 'Please Select Team Member'
                : null,
          ),
          addVertical(12),
          CustomDropDown<String>(
            title: 'Services',
            hintText: 'Select',
            isRequired: true,
            value: addDirectorVM.selectdService?.id,
            items: serviceList
                    ?.map((e) => DropdownMenuItem<String>(
                          value: e.id,
                          child: Text(e.name ?? ''),
                        ))
                    .toList() ??
                [],
            onChanged: (val) {
              if (val != null) {
                final member = serviceList?.firstWhere((m) => m.id == val);
                addDirectorVM.selectdService = member;
              }
            },
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
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please Select a Day'
                      : null,
                ),
              ),
              addHorizontal(12),
              Flexible(
                flex: 1,
                child: InputTextField(
                    title: "Service Time In Min",
                    hintText: "100",
                    readOnly: true,
                    controller: addDirectorVM.serviceTimemInCntr),
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
                  controller: addDirectorVM.serviceStartTimeCntr,
                  readOnly: true,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        addDirectorVM.serviceStartTimeCntr.text =
                            picked.format(context);
                        addDirectorVM.generateTimeSlots(context);
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
                  controller: addDirectorVM.serviceEndTimeCntr,
                  readOnly: true,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        addDirectorVM.serviceEndTimeCntr.text =
                            picked.format(context);
                        addDirectorVM.generateTimeSlots(context);
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
                  controller: addDirectorVM.breakStartTimeCntr,
                  readOnly: true,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        addDirectorVM.breakStartTimeCntr.text =
                            picked.format(context);
                        addDirectorVM.generateTimeSlots(context);
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
                  controller: addDirectorVM.breakEndTimeCntr,
                  readOnly: true,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        addDirectorVM.breakEndTimeCntr.text =
                            picked.format(context);
                        addDirectorVM.generateTimeSlots(context);
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
}
