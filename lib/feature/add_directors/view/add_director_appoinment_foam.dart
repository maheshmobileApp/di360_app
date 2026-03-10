import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_multi_select_dropdown.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorAppoinmentFoam extends StatefulWidget {
  @override
  State<AddDirectorAppoinmentFoam> createState() =>
      _AddDirectorAppoinmentFoamState();
}

class _AddDirectorAppoinmentFoamState extends State<AddDirectorAppoinmentFoam>
    with BaseContextHelpers {
  AddDirectoryViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel ??= context.read<AddDirectoryViewModel>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TimeOfDay? _parseTime(String timeStr) {
    if (timeStr.isEmpty) return null;
    try {
      final parts = timeStr.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1].split(' ')[0]);
      if (timeStr.contains('PM') && hour != 12) hour += 12;
      if (timeStr.contains('AM') && hour == 12) hour = 0;
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return null;
    }
  }

  bool _isTimeBetween(TimeOfDay time, TimeOfDay start, TimeOfDay end) {
    final timeMinutes = time.hour * 60 + time.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return timeMinutes >= startMinutes && timeMinutes <= endMinutes;
  }

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final teamMemberList = addDirectorVM
            .getBasicInfoData.first.directoryTeamMembers
            ?.where((e) => e.showInAppointments == true)
            .toList() ??
        [];
    final serviceList =
        addDirectorVM.getBasicInfoData.first.directoryServices?.where((e) {
              final show = e.showInAppointments;
              return show == true ||
                  (show is String && show.toLowerCase() == 'yes');
            }).toList() ??
            [];
    final daysList = ConstantData.DaysList.toSet().toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sectionHeader("Add Appointments"),
              InkWell(
                  onTap: () => navigationService.goBack(),
                  child: Icon(Icons.close, color: AppColors.black))
            ],
          ),
          sectionHeader(""),
          addVertical(12),
          dropdownTitle('Select Team Member'),
          CustomMultiSelectDropDown<String>(
            items: teamMemberList.map((e) => e.name ?? '').toList(),
            selectedItems: addDirectorVM.selectedTeamMemberList,
            itemLabel: (item) => item,
            hintText: "Select ",
            onSelectionChanged: (selected) {
              addDirectorVM.clearTeamMemberList();
              for (final item in selected) {
                addDirectorVM.addTeamMemberList(item);
              }
            },
          ),
          addVertical(12),
          dropdownTitle('Select Services'),
          CustomMultiSelectDropDown<String>(
            items: serviceList.map((e) => e.name ?? '').toList(),
            selectedItems: addDirectorVM.selectedServiceList,
            itemLabel: (item) => item,
            hintText: "Select ",
            onSelectionChanged: (selected) {
              addDirectorVM.clearServicesList();
              for (final item in selected) {
                addDirectorVM.addServicesList(item);
              }
            },
          ),
          addVertical(12),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dropdownTitle('Select a day'),
                    CustomMultiSelectDropDown<String>(
                      items: daysList,
                      selectedItems: addDirectorVM.selectedDaysList,
                      itemLabel: (item) => item,
                      hintText: "Select ",
                      onSelectionChanged: (selected) {
                        addDirectorVM.clearDaysList();
                        for (final item in selected) {
                          addDirectorVM.addDaysList(item);
                        }
                      },
                    ),
                  ],
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
                      prefixIcon: Icon(Icons.access_time, size: 20))),
              addHorizontal(12),
              Flexible(
                  flex: 1,
                  child: InputTextField(
                      title: "Service End Time",
                      hintText: "00:00",
                      controller: addDirectorVM.serviceEndTimeCntr,
                      readOnly: true,
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
                      prefixIcon: Icon(Icons.access_time, size: 20))),
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
                      onTap: () async {
                        final startTime =
                            _parseTime(addDirectorVM.serviceStartTimeCntr.text);
                        final endTime =
                            _parseTime(addDirectorVM.serviceEndTimeCntr.text);

                        if (startTime == null || endTime == null) {
                          showTopMessage(context,
                              'Please set service start and end time first');

                          return;
                        }

                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          if (!_isTimeBetween(picked, startTime, endTime)) {
                            showTopMessage(context,
                                'Break start time must be between service start and end time');
                            return;
                          }
                          addDirectorVM.breakStartTimeCntr.text =
                              picked.format(context);
                          addDirectorVM.generateTimeSlots(context);
                        }
                      },
                      prefixIcon: Icon(Icons.access_time, size: 20))),
              addHorizontal(12),
              Flexible(
                  flex: 1,
                  child: InputTextField(
                      title: "Break End Time",
                      hintText: "00:00",
                      controller: addDirectorVM.breakEndTimeCntr,
                      readOnly: true,
                      onTap: () async {
                        final startTime =
                            _parseTime(addDirectorVM.serviceStartTimeCntr.text);
                        final endTime =
                            _parseTime(addDirectorVM.serviceEndTimeCntr.text);
                        final breakStart =
                            _parseTime(addDirectorVM.breakStartTimeCntr.text);

                        if (startTime == null || endTime == null) {
                          showTopMessage(context,
                              'Please set service start and end time first');
                          ;
                          return;
                        }

                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          if (!_isTimeBetween(picked, startTime, endTime)) {
                            showTopMessage(context,
                                'Break end time must be between service start and end time');

                            return;
                          }
                          if (breakStart != null) {
                            final breakStartMin =
                                breakStart.hour * 60 + breakStart.minute;
                            final pickedMin = picked.hour * 60 + picked.minute;
                            if (pickedMin <= breakStartMin) {
                              showTopMessage(context,
                                  'Break end time must be after break start time');

                              return;
                            }
                          }
                          addDirectorVM.breakEndTimeCntr.text =
                              picked.format(context);
                          addDirectorVM.generateTimeSlots(context);
                        }
                      },
                      prefixIcon: Icon(Icons.access_time, size: 20))),
            ],
          ),
        ],
      ),
    );
  }

  Widget dropdownTitle(String title) {
    return Column(
      children: [
        Text(title, style: TextStyles.regular3(color: AppColors.black)),
        addVertical(4)
      ],
    );
  }
}
