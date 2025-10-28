import 'package:di360_flutter/feature/my_learning_hub/view_model/filter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';

class FilterBottomSheet extends StatelessWidget {
  final VoidCallback onApply;
  final VoidCallback onClear;

  const FilterBottomSheet({
    super.key,
    required this.onApply,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Use already provided FilterViewModel (no re-create)
    final vm = Provider.of<FilterViewModel>(context, listen: true);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filter",
                    style: TextStyles.bold4(color: AppColors.primaryColor),
                  ),
                  TextButton(
                    onPressed: () {
                      vm.clearAll();
                      onClear();
                    },
                    child: Text(
                      "Clear all",
                      style:
                          TextStyles.regular3(color: AppColors.lightGeryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Dynamic Sections
              ...vm.sections.map(
                (section) => _FilterSection(
                  title: section.title,
                  options: section.options,
                  selectedOption: vm.selectedOptions[section.title],
                  onOptionSelected: (value) =>
                      vm.selectOption(section.title, value),
                ),
              ),
              const SizedBox(height: 8),

              // Date Picker
              CustomDatePicker(
                title: "Filter by Date",
                controller: vm.dateController,
                hintText: "Select Date",
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    vm.selectDate(picked);
                  }
                },
              ),

              const SizedBox(height: 8),

              // Location Field
              /*InputTextField(
                controller: vm.locationController,
                hintText: "Enter Location",
                title: "Filter by Location",
                onChange: vm.updateLocation,
              ),*/

              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomRoundedButton(
                      text: 'Cancel',
                      height: 40,
                      backgroundColor: AppColors.timeBgColor,
                      textColor: AppColors.primaryColor,
                      onPressed: () {
                        navigationService.goBack();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      height: 40,
                      text: 'Apply',
                      onTap: onApply
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String?> onOptionSelected;

  const _FilterSection({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.hintColor,
            ),
            child: Column(
              children: options.map((option) {
                return RadioListTile<String>(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(option, style: TextStyles.medium2()),
                  value: option,
                  groupValue: selectedOption,
                  activeColor: AppColors.primaryColor,
                  onChanged: onOptionSelected,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
