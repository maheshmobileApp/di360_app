import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/job_seek/widget/multidatecalendarpicker.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JobProfileAvailability extends StatelessWidget with BaseContextHelpers {
  const JobProfileAvailability({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProfileVM = Provider.of<JobProfileViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Availability"),
            addVertical(16),
            Text("Willing to travel", style: TextStyles.regular2()),
            addVertical(6),
            Row(
              children: [
                _radioButton("Yes", true, jobProfileVM.isWillingToTravel,
                    (_) => jobProfileVM.toggleWillingToTravel(true)),
                _radioButton("No", false, jobProfileVM.isWillingToTravel,
                    (_) => jobProfileVM.toggleWillingToTravel(false)),
              ],
            ),
            if (jobProfileVM.isWillingToTravel) ...[
              addVertical(10),
              InputTextField(
                hintText: "Enter distance in Km",
                title: "Distance to Travel (Km)",
                keyboardType: TextInputType.number,
              ),
            ],
            addVertical(20),
            Text("Joining", style: TextStyles.regular2()),
            addVertical(6),
            Row(
              children: [
                _radioButton("Immediate", true, jobProfileVM.isJoiningImmediate,
                    (_) => jobProfileVM.toggleJoiningImmediate(true)),
                _radioButton(
                  "From Date",
                  false,
                  jobProfileVM.isJoiningImmediate,
                  (_) => jobProfileVM.toggleJoiningImmediate(false),
                ),
              ],
            ),
            if (!jobProfileVM.isJoiningImmediate) ...[
              addVertical(10),
              MultiDateCalendarPicker(
                selectedDates: jobProfileVM.joiningDates,
                onToggleDate: (date) {
                  jobProfileVM.toggleJoiningDate(date);
                },
              ),
              addVertical(12),
              if (jobProfileVM.joiningDates.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: jobProfileVM.joiningDates.map((date) {
                    return Chip(
                      label: Text(DateFormat('MMM d, yyyy').format(date)),
                      onDeleted: () => jobProfileVM.removeJoiningDate(date),
                    );
                  }).toList(),
                ),
            ],
            addVertical(20),
            Text("Availability Type", style: TextStyles.regular2()),
            addVertical(6),
            CustomDropDown<String>(
              title: '',
              hintText: 'Select Availability Type',
              value: jobProfileVM.selectedAvailabilityType,
              items: jobProfileVM.availabilityTypes
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                jobProfileVM.setAvailabilityType(val ?? '');
              },
            ),
            addVertical(16),
            if (jobProfileVM.selectedAvailabilityType == 'Select Date') ...[
              Text("Select Availability Date", style: TextStyles.regular2()),
              addVertical(6),
              MultiDateCalendarPicker(
                selectedDates: jobProfileVM.availabilityDates,
                onToggleDate: (date) {
                  jobProfileVM.toggleAvailabilityDate(date);
                },
              ),
              addVertical(12),
              if (jobProfileVM.availabilityDates.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: jobProfileVM.availabilityDates.map((date) {
                    return Chip(
                      label: Text(DateFormat('MMM d, yyyy').format(date)),
                      onDeleted: () =>
                          jobProfileVM.removeAvailabilityDate(date),
                    );
                  }).toList(),
                ),
            ],
            if (jobProfileVM.selectedAvailabilityType == 'Select Day') ...[
              Text("Available Days", style: TextStyles.regular2()),
              addVertical(6),
              Wrap(
                spacing: 10,
                runSpacing: 6,
                children: jobProfileVM.weekDays.map((day) {
                  final isSelected = jobProfileVM.selectedDays.contains(day);
                  return FilterChip(
                    label: Text(day),
                    selected: isSelected,
                    onSelected: (_) => jobProfileVM.toggleDay(day),
                    selectedColor: AppColors.buttonColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _radioButton(String label, bool value, bool groupValue,
      ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<bool>(
          visualDensity: VisualDensity.compact,
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(label, style: TextStyles.regular2()),
        const SizedBox(width: 20),
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
