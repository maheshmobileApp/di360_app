import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_seek/widget/collasible_section.dart';
import 'package:di360_flutter/feature/job_seek/widget/multidatecalendarpicker.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
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
        backgroundColor: AppColors.buttomBarColor,
      appBar: AppbarTitleBackIconWidget(title: 'Filter Talents'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              addVertical(10),
              _buildLocationSearchBar(context, model),
              addVertical(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildDropdownSection(
                            title: 'Filter by Availability Dates',
                            dropdown: _availabilityDate(context, model),
                          ),
                          const Divider(),
                          _buildFilterSection(
                            context,
                            title: 'Filter by Availability Days',
                            options: model
                                .getSortedDaysOptions()
                                .map((e) => e.name)
                                .toList(),
                            selectedIndices:
                                model.selectedIndices['availability'] ?? {},
                            onToggle: (i) =>
                                model.selectItem('availability', i),
                          ),
                          const Divider(),
                          _buildFilterSection(
                            context,
                            title: "Filter by Profession",
                            options: model
                                .getSortedProfessionOptions()
                                .map((e) => e.name)
                                .toList(),
                            selectedIndices:
                                model.selectedIndices['profession'] ?? {},
                            onToggle: (index) =>
                                model.selectItem('profession', index),
                          ),
                          const Divider(),
                          _buildFilterSection(
                            context,
                            title: "Filter by Employment Type",
                            options: model
                                .getSortedEmploymentOptions()
                                .map((e) => e.name)
                                .toList(),
                            selectedIndices:
                                model.selectedIndices['employment'] ?? {},
                            onToggle: (index) =>
                                model.selectItem('employment', index),
                          ),
                          const Divider(),
                          _buildDropdownSection(
                            title: "Filter by Experience",
                            dropdown: CustomDropDown<String>(
                              hintText: 'Select Experience',
                              title: "",
                              items: model.experienceOptions
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: TextStyles.regular3(
                                            color: AppColors.lightGeryColor,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: model.selectedExperienceDropdown,
                              onChanged: (val) {
                                if (val != null) model.setExperience(val);
                              },
                            ),
                          ),
                          const Divider(),
                          _buildDropdownSection(
                            title: "Sort By Alphabetical Order",
                            dropdown: CustomDropDown<String>(
                              hintText: 'Select Sort Order',
                              title: "",
                              items: model.sortOptions
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: TextStyles.regular3(
                                            color: AppColors.lightGeryColor,
                                          ),
                                        ),
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppButton(
                      text: 'Clear',
                      height: 40,
                      width: 150,
                      onTap: () async {
                        model.clearSelections();
                        await model.fetchFilteredJobs(context);
                      },
                    ),
                    AppButton(
                      text: 'Apply',
                      height: 40,
                      width: 150,
                      onTap: () async {
                        model.printSelectedItems();
                        await model.fetchFilteredJobs(context);
                        navigationService.goBack();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(
    BuildContext context, {
    required String title,
    required List<String> options,
    required Set<int> selectedIndices,
    required Function(int) onToggle,
    Widget? child,
  }) {
    return CollapsibleSection(
      title: title,
      child: Column(
        children: [
          ...List.generate(options.length, (index) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: selectedIndices.contains(index),
              activeColor: AppColors.primaryColor,
              onChanged: (_) => onToggle(index),
              title: Text(
                options[index],
                style: TextStyles.regular3(color: AppColors.lightGeryColor),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
          if (child != null) child,
        ],
      ),
    );
  }

  Widget _buildLocationSearchBar(BuildContext context,TalentsViewModel model) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: model.locationController,
                decoration: InputDecoration(
                  hintText: 'Search Location',
                  hintStyle: TextStyles.dmsansLight(
                    color: AppColors.black,
                    fontSize: 18,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      await model.fetchFilteredJobs(context);
                      navigationService.goBack();
                    },
                    child: const Icon(Icons.search, color: AppColors.black),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            /*addHorizontal(10),
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.black,
              child: const Icon(Icons.filter_alt,
                  color: AppColors.whiteColor, size: 20),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _availabilityDate(BuildContext context, TalentsViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiDateCalendarPicker(
          initialDate: DateTime.now(),
          firstDate: DateTime.utc(2000),
          selectedDates: model.availabilityDates,
          controller: model.availabilityDateController,
          onDatesChanged: (dates) {
            model.availabilityDates = dates;
            model.updateAvailabilityDateControllerText();
          },
        ),
        const SizedBox(height: 8),
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

  Widget _buildDropdownSection({
    required String title,
    required Widget dropdown,
  }) {
    return CollapsibleSection(
      title: title,
      child: dropdown,
    );
  }
}
