import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorTimingsFoam extends StatelessWidget with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addTimings(addDirectorVM, context),
          addVertical(20),
          socialUrlsWidget(addDirectorVM,context)
        ],
      ),
    );
  }

  Widget addTimings(AddDirectorViewModel addDirectorVM, BuildContext context) {
    final daysList = addDirectorVM.DaysList.toSet().toList();
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          sectionHeader("Add Timings"),
          addVertical(12),
          CustomDropDown<String>(
            title: 'Select a day',
            hintText: 'Select',
            isRequired: true,
            value: daysList.contains(addDirectorVM.selectedDays)
                ? addDirectorVM.selectedDays
                : null,
            items: daysList
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {
              addDirectorVM.selectWeekCntr.text = val ?? '';
              return addDirectorVM.selectedDays = val;
            },
            validator: (value) =>
                value == null || value.isEmpty ? 'Please Select a Day' : null,
          ),
          // InputTextField(
          //   title: "Select Time",
          //   hintText: "Select Date",
          //   controller: AddDirectorVM.SelectTimeController,
          //   readOnly: true,
          //   prefixIcon: GestureDetector(
          //     onTap: () async {
          //       final picked = await showDatePicker(
          //         context: context,
          //         initialDate: DateTime.now(),
          //         firstDate: DateTime(2000),
          //         lastDate: DateTime(2100),
          //       );
          //       if (picked != null) {
          //         AddDirectorVM.setSelectedTime(picked);
          //         AddDirectorVM.SelectTimeController.text =
          //             "${picked.day}/${picked.month}/${picked.year}";
          //       }
          //     },
          //     child: Icon(Icons.calendar_today_outlined, size: 20),
          //   ),
          //   suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColors.black),
          // ),
          addVertical(12),
          Row(
            children: [
              Expanded(
                child: InputTextField(
                  title: "Service Start Time",
                  hintText: "00:00",
                  controller: addDirectorVM.serviceStartTimeCntr,
                  readOnly: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter service start time'
                      : null,
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
                        addDirectorVM.serviceStartTimeCntr.text =
                            picked.format(context);
                      }
                    },
                    child: Icon(Icons.access_time, size: 20),
                  ),
                ),
              ),
              addHorizontal(12),
              Expanded(
                child: InputTextField(
                  title: "Service End Time",
                  hintText: "00:00",
                  controller: addDirectorVM.serviceEndTimeCntr,
                  readOnly: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter service end time'
                      : null,
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
                        addDirectorVM.serviceEndTimeCntr.text =
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
          AppButton(
            text: 'Add',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                addDirectorVM.addLocations(context);
                navigationService.goBack();
              }
            },
          )
        ],
      ),
    );
  }

  Widget socialUrlsWidget(
      AddDirectorViewModel addDirectorVM, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      sectionHeader("Add social links"),
      addVertical(12),
      CustomDropDown<String>(
        title: 'Account',
        hintText: 'Select Account',
        isRequired: true,
        value: addDirectorVM.selectedAccount,
        items: addDirectorVM.AccountList.map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            )).toList(),
        onChanged: (val) {
          addDirectorVM.selectedAccount = val;
        },
        validator: (value) =>
            value == null || value.isEmpty ? 'Please Select Account' : null,
      ),
      addVertical(16),
      InputTextField(
        title: "Social Accounts URL",
        hintText: "Paste/enter link",
        keyboardType: TextInputType.emailAddress,
        controller: addDirectorVM.socialAccountsurlCntr,
        validator: (value) =>
            value == null || value.isEmpty ? 'Please select urls' : null,
      ),
      addVertical(20),
      AppButton(
        text: 'Add',
        onTap: () {
          if (addDirectorVM.selectedAccount == null && addDirectorVM.socialAccountsurlCntr.text.isEmpty) {
            showTopMessage(context, 'select socail account & account url');
          } else {
            addDirectorVM.addSocialUrls(context);
            navigationService.goBack();
          }
        },
      )
    ]);
  }
}
