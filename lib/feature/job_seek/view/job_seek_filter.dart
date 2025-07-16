import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_seek/widget/multidatecalendarpicker.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';

class JobSeekFilterScreen extends StatelessWidget with BaseContextHelpers {
  const JobSeekFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<JobSeekViewModel>(context);

    return Scaffold(
  backgroundColor: AppColors.whiteColor,
  appBar: AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: AppColors.whiteColor,
    elevation: 0,
    title: Text(
      "Filter Jobs",
      style: TextStyle(fontSize: 20, color: AppColors.black),
    ),
    iconTheme: IconThemeData(color: AppColors.black),
  ),
  body: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(16.0), 
      child: Column(
        children: [
          Expanded(
            child: ListView(
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
                    await model.fetchJobs();
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

  Widget buildFilters(BuildContext context, JobSeekViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
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
                title: 'Filter by Profession',
                options: model.filterOptions['profession']
                        ?.map((e) => e.name)
                        .toList() ??
                    [],
                selectedIndices: model.selectedIndices['profession'] ?? {},
                onToggle: (index) => model.selectItem('profession', index),
              ),
              _filterSection(
                title: 'Filter by Employment Type',
                options: model.filterOptions['employment']
                        ?.map((e) => e.name)
                        .toList() ??
                    [],
                selectedIndices: model.selectedIndices['employment'] ?? {},
                onToggle: (index) => model.selectItem('employment', index),
                child: model.showLocumDate
                    ? _locumDateSection(context, model)
                    : null,
              ),
              _filterSectionWithDropdown(
                title: 'Filter by Experience',
                child: CustomDropDown<String>(
                  title: '',
                  hintText: 'Select Experience',
                  items: model.experienceOptions
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyles.regular3(
                                color: AppColors.lightGeryColor),
                          ),
                        ),
                      )
                      .toList(),
                  value:
                      model.selectedExperienceDropdown, 
                  onChanged: (val) {
                    if (val != null)
                      model.setExperience(val); 
                  },
                ),
              ),
              _filterSectionWithDropdown(
                title: 'Sort By Alphabetical Order',
                child: CustomDropDown<String>(
                  title: '',
                  hintText: 'Select Sort Order',
                  items: model.sortOptions
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyles.regular3(
                                color: AppColors.lightGeryColor),
                          ),
                        ),
                      )
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
      ),
    );
  }

  Widget _locationSearchBar(JobSeekViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Container(
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
                      hintStyle:
                          TextStyles.regular3(color: AppColors.lightGeryColor),
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
          ),
        ),
      ],
    );
  }

  Widget _filterSection({
    required String title,
    required List<String> options,
    required Set<int> selectedIndices,
    required Function(int) onToggle,
    Widget? child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Text(
              title,
              style: TextStyles.regular3(color: AppColors.black),
            ),
            initiallyExpanded: true,
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              if (options.isNotEmpty)
                ...List.generate(options.length, (index) {
                  final opt = options[index];
                  return CheckboxListTile(
                    title: Text(
                      opt,
                      style:
                          TextStyles.regular3(color: AppColors.lightGeryColor),
                    ),
                    value: selectedIndices.contains(index),
                    onChanged: (_) => onToggle(index),
                    activeColor: AppColors.primaryColor,
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  );
                }),
              if (child != null) child,
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget _filterSectionWithDropdown({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData().copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Text(
              title,
              style: TextStyles.regular3(color: AppColors.black),
            ),
            trailing: const Icon(Icons.expand_more),
            initiallyExpanded: true,
            childrenPadding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            children: [
              child,
            ],
          ),
        ),
      ],
    );
  }

  Widget _locumDateSection(BuildContext context, JobSeekViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiDateCalendarPicker(
          selectedDates: model.selectedLocumDatesObjects,
          onToggleDate: (date) {
            model.toggleLocumDate(date);
            model.updateLocumDateControllerText();
          },
          title: "Availability Date",
        ),
        const SizedBox(height: 12),
        if (model.selectedLocumDates.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: model.selectedLocumDatesObjects.map((date) {
              return Chip(
                label: Text(DateFormat('MMM d, yyyy')
                    .format(date)), 
                onDeleted: () {
                  model.removeLocumDate(date); 
                },
              );
            }).toList(),
          ),
      ],
    );
  }
}
