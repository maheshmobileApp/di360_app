import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorTimingsFoam extends StatelessWidget with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final AddDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Add Timings"),
          addVertical(12),
          InputTextField(
            title: "Select Time",
            hintText: "Select Date",
            controller: AddDirectorVM.SelectTimeController,
            readOnly: true,
            prefixIcon: GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  AddDirectorVM.setSelectedTime(picked);
                  AddDirectorVM.SelectTimeController.text =
                      "${picked.day}/${picked.month}/${picked.year}";
                }
              },
              child: Icon(Icons.calendar_today_outlined, size: 20),
            ),
            suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColors.black),
          ),
          addVertical(12),
          Row(
            children: [
              Expanded(
                child: InputTextField(
                  title: "Service Start Time",
                  hintText: "00:00",
                  controller: AddDirectorVM.SelectServiceStartTimeController,
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
                        AddDirectorVM.setServiceStartTimeDate(dateTime);
                        AddDirectorVM.SelectServiceStartTimeController.text =
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
                  controller: AddDirectorVM.SelectServiceEndTimeController,
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
                        AddDirectorVM.setServiceEndTimeDate(dateTime);
                        AddDirectorVM.SelectServiceEndTimeController.text =
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
              _radioButton(
                "All Day",
                true,
                AddDirectorVM.AllDay,
                (_) => AddDirectorVM.toggleAllDay(true),
              ),
              addHorizontal(5),
              Expanded(
                child: InputTextField(
                  title: "",
                  hintText: "Repeat",
                  readOnly: true,
                  suffixIcon:
                      Icon(Icons.keyboard_arrow_down, color: AppColors.black),
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
  Widget _radioButton(
    String label,
    bool value,
    bool groupValue,
    ValueChanged<bool?> onChanged,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<bool>(
          visualDensity: VisualDensity.compact,
          value: value,
          groupValue: groupValue,
          activeColor: AppColors.buttonColor,
          onChanged: onChanged,
        ),
        Text(label, style: TextStyles.regular2()),
        const SizedBox(width: 20),
      ],
    );
  }
}
