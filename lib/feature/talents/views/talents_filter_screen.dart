import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_seek/widget/multidatecalendarpicker.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:intl/intl.dart';

class TalentsFilterScreen extends StatelessWidget with BaseContextHelpers {
  const TalentsFilterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TalentsViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: const Text(
          "Filter Jobs",
          style: TextStyle(fontSize: 20, color: AppColors.black),
        ),
        iconTheme: const IconThemeData(color: AppColors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: model.filterOptions.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        children: [
                          buildFilters(context, model),
                        ],
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomRoundedButton(
                      text: 'Clear',
                      fontSize: 16,
                      height: 42,
                      onPressed: () async {
                        model.clearSelections();
                        navigationService.goBack();
                      },
                      backgroundColor: AppColors.timeBgColor,
                      textColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomRoundedButton(
                      text: 'Apply',
                      fontSize: 16,
                      height: 42,
                      onPressed: () async {
                        model.printSelectedItems();
                        await model.fetchFilteredJobs(context);
                        navigationService.goBack();
                      },
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
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

  Widget buildFilters(BuildContext context, TalentsViewModel model) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            _filterSection(
              title: 'Filter by Location',
              options: const [],
              selectedIndices: const {},
              onToggle: (_) {},
              child: _locationSearchBar(model),
            ),
            _filterSection(
              title: 'Filter by Availability Dates',
              options: const [],
              selectedIndices: const {},
              onToggle: (_) {},
              child: _AvailabilityDate(context, model),
            ),
            _filterSection(
              title: 'Filter by  Availability Days',
              options: model.getSortedDaysOptions().map((e) => e.name).toList(),
              selectedIndices: model.selectedIndices['availability']?? {},
              onToggle: (index) => model.selectItem('availability', index),
            ),
            _filterSection( 
              title: 'Filter by Profession',
              options:
                  model.getSortedProfessionOptions().map((e) => e.name).toList(),
              selectedIndices: model.selectedIndices['profession'] ?? {},
              onToggle: (index) => model.selectItem('profession', index),
            ),
            _filterSection(
              title: 'Filter by Employment Type',
              options:
                  model.getSortedEmploymentOptions().map((e) => e.name).toList(),
              selectedIndices: model.selectedIndices['employment'] ?? {},
              onToggle: (index) => model.selectItem('employment', index),
            ),
            _filterSectionWithDropdown(
              title: 'Filter by Experience',
              child: CustomDropDown<String>(
                hintText: 'Select Experience',
                title: "",
                items: model.experienceOptions
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e,
                              style: TextStyles.regular3(
                                  color: AppColors.lightGeryColor)),
                        ))
                    .toList(),
                value: model.selectedExperienceDropdown,
                onChanged: (val) {
                  if (val != null) model.setExperience(val);
                },
              ),
            ),
            _filterSectionWithDropdown(
              title: 'Sort By Alphabetical Order',
              child: CustomDropDown<String>(
                hintText: 'Select Sort Order',
                title: "",
                items: model.sortOptions
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e,
                              style: TextStyles.regular3(
                                  color: AppColors.lightGeryColor)),
                        ))
                    .toList(),
                value: model.selectedSort,
                onChanged: (val) {
                  if (val != null) model.setSort(val);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationSearchBar(TalentsViewModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: model.locationController,
              decoration: InputDecoration(
                hintText: 'Search Location',
                hintStyle: TextStyles.regular3(color: AppColors.lightGeryColor),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, size: 22),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _filterSection({
    required String title,
    required List<String> options,
    required Set<int> selectedIndices,
    required Function(int) onToggle,
    Widget? child,
  }) {
    return ExpansionTile(
      title: Text(title, style: TextStyles.regular3(color: AppColors.black)),
      initiallyExpanded: true,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        if (options.isNotEmpty)
          ...List.generate(options.length, (index) {
            return CheckboxListTile(
              title: Text(options[index],
                  style: TextStyles.regular3(color: AppColors.lightGeryColor)),
              value: selectedIndices.contains(index),
              onChanged: (_) => onToggle(index),
              activeColor: AppColors.primaryColor,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            );
          }),
        if (child != null) child,
        Divider(),
      ],
    );
  }

  Widget _filterSectionWithDropdown({
    required String title,
    required Widget child,
  }) {
    return ExpansionTile(
      title: Text(title, style: TextStyles.regular3(color: AppColors.black)),
      initiallyExpanded: true,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      children: [child],
    );
  }
  Widget _AvailabilityDate(BuildContext context, TalentsViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        MultiDateCalendarPicker(
          selectedDates: model.availabilityDates,
          controller: model.availabilityDateController,
          onDatesChanged: (dates) {
            model.availabilityDates = dates;
            model.updateAvailabilityDateControllerText();
          },
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: model.availabilityDates.map((date) {
            return Chip(
              label: Text(DateFormat('MMM d, yyyy').format(date)),
              onDeleted: () {
                model.removeAvailabilityDate(date);
                if (model.availabilityDates.isEmpty) {
                  model.availabilityDateController.clear();
                } else {
                  model.updateAvailabilityDateControllerText();
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
