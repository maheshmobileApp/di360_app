import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/my_learning_hub/model/filter_section_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  final List<FilterSectionModel> sections;
  final VoidCallback onApply;
  final VoidCallback onClear;

  const FilterBottomSheet({
    super.key,
    required this.sections,
    required this.onApply,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  onPressed: onClear,
                  child: Text("Clear all",
                      style:
                          TextStyles.regular3(color: AppColors.lightGeryColor)),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Dynamic filter sections
            ...sections.map(
              (section) => _FilterSection(
                title: section.title,
                options: section.options,
              ),
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                    child: AppButton(
                  text: 'Cancel',
                  height: 40,
                  onTap: () {
                    navigationService.goBack();
                  },
                )),
                const SizedBox(width: 12),
                Expanded(
                    child: AppButton(
                  height: 40,
                  text: 'Apply',
                  onTap: () {
                    navigationService.goBack();
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterSection extends StatefulWidget {
  final String title;
  final List<String> options;

  const _FilterSection({
    required this.title,
    required this.options,
  });

  @override
  State<_FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<_FilterSection> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 8),
          Column(
            children: widget.options.map((option) {
              return RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: Text(option),
                value: option,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
