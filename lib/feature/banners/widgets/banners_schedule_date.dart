import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/banners/view_model/banners_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BannersScheduleExpiryPage extends StatelessWidget {
  const BannersScheduleExpiryPage({super.key});

  Future<void> _pickScheduleDate(BuildContext context) async {
    final provider = context.read<BannersViewModel>();
    provider.scheduleDate = null;
    final picked = await showDatePicker(
      context: context,
      initialDate: provider.scheduleDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      provider.setScheduleDate(picked);
    }
  }

  Future<void> _pickExpiryDate(BuildContext context) async {
    final provider = context.read<BannersViewModel>();
    provider.expiryDate = null;
    if (provider.scheduleDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select Schedule date first")),
      );
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: provider.expiryDate ??
          provider.scheduleDate!.add(const Duration(days: 1)),
      firstDate: provider.scheduleDate!.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      provider.setExpiryDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BannersViewModel>(
      builder: (context, provider, child) {
        return Row(
          children: [
            Expanded(
              child: DatePickerField(
                label: "Schedule Date",
                selectedDate: provider.scheduleDate,
                onTap: () => _pickScheduleDate(context),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DatePickerField(
                label: "Expiry Date",
                selectedDate: provider.expiryDate,
                onTap: () => _pickExpiryDate(context),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const DatePickerField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd-MM-yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyles.regular3(color: AppColors.black),
            ),
            Text("*", style: TextStyles.regular3(color: AppColors.redColor),)
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(left: 16, right: 32),
            backgroundColor: AppColors.whiteColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.dropDownHint,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: Icon(
            Icons.calendar_today_outlined,
            color: AppColors.dropDownHint,
          ),
          label: Text(
            selectedDate != null
                ? formatter.format(selectedDate!)
                : "Select date",
            style: selectedDate != null
                ? TextStyles.medium2(color: AppColors.black)
                : TextStyles.regular1(color: AppColors.dropDownHint),
          ),
          onPressed: onTap,
        ),
      ],
    );
  }
}
