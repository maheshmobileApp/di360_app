import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/my_learning_hub/model/filter_section_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<FilterSectionModel> sections;
  final Function(Map<String, String?> selectedOptions) onApply;
  final VoidCallback onClear;

  const FilterBottomSheet({
    super.key,
    required this.sections,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Store selected option for each section
  final Map<String, String?> selectedOptions = {};
  final TextEditingController locationController = TextEditingController();

  void _onOptionSelected(String sectionTitle, String? option) {
    setState(() {
      selectedOptions[sectionTitle] = option;
    });
  }

  void _onDateSelected(DateTime picked) {
    final formattedDate = "${picked.year}-${picked.month}-${picked.day}";
    setState(() {
      selectedOptions["Filter by Date"] = formattedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              // Top handle
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

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filter",
                    style: TextStyles.bold4(color: AppColors.primaryColor),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedOptions.clear();
                      });
                      widget.onClear();
                    },
                    child: Text("Clear all",
                        style: TextStyles.regular3(
                            color: AppColors.lightGeryColor)),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Dynamic filter sections
              ...widget.sections.map(
                (section) => _FilterSection(
                  title: section.title,
                  options: section.options,
                  selectedOption: selectedOptions[section.title],
                  onOptionSelected: (value) =>
                      _onOptionSelected(section.title, value),
                ),
              ),

              const SizedBox(height: 8),

              CustomDatePicker(
                title: "Filter by Date",
                controller: TextEditingController(
                  text: selectedOptions["Filter by Date"] ?? "",
                ),
                hintText: "Select Date",
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    _onDateSelected(picked);
                  }
                },
              ),

              const SizedBox(height: 8),

              InputTextField(
                controller: locationController,
                hintText: "Enter Location",
                title: "Filter by Location",
              ),

              const SizedBox(height: 24),

              // Buttons
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
                      onTap: () {
                        selectedOptions["Filter by Location"] =
                            locationController.text.isNotEmpty
                                ? locationController.text
                                : null;

                        widget.onApply(selectedOptions);
                        navigationService.goBack();
                      },
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
