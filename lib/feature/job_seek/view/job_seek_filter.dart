import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_seek/widget/collasible_section.dart';
import 'package:di360_flutter/feature/job_seek/widget/multidatecalendarpicker.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:intl/intl.dart';

class JobSeekFilterScreen extends StatelessWidget with BaseContextHelpers {
  const JobSeekFilterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<JobSeekViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.buttomBarColor,
        appBar: AppbarTitleBackIconWidget(title: 'Filter Jobs'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                addVertical(10),
                _buildLocationSearchBar(context,model),
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
                            Divider(),
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
                              child: model.showLocumDate
                                  ? _buildLocumDateSection(context, model)
                                  : null,
                            ),
                            Divider(),
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
                            Divider(),
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
        ));
  }

  Widget _buildLocationSearchBar(BuildContext context, JobSeekViewModel model) {
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
                  hintText: 'Search location',
                  hintStyle: TextStyles.dmsansLight(
                    color: AppColors.black,
                    fontSize: 18,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      model.printSelectedItems();
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

  // --- DROPDOWN SECTION ---
  Widget _buildDropdownSection({
    required String title,
    required Widget dropdown,
  }) {
    return CollapsibleSection(
      title: title,
      child: dropdown,
    );
  }

  // --- LOCUM DATE SECTION ---
  Widget _buildLocumDateSection(BuildContext context, JobSeekViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiDateCalendarPicker(
          initialDate: DateTime.now(),
          firstDate: DateTime.utc(2000),
          selectedDates: model.selectedLocumDatesObjects,
          controller: model.locumDateController,
          onDatesChanged: (dates) {
            model.selectedLocumDatesObjects = dates;
            model.updateLocumDateControllerText();
          },
          title: "Availability Date",
        ),
        const SizedBox(height: 12),
        if (model.selectedLocumDatesObjects.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: model.selectedLocumDatesObjects.map((date) {
              return Chip(
                label: Text(DateFormat('MMM d, yyyy').format(date)),
                onDeleted: () => model.removeLocumDate(date),
              );
            }).toList(),
          ),
      ],
    );
  }

  // small helper widgets
  SizedBox addVertical(double h) => SizedBox(height: h);
  SizedBox addHorizontal(double w) => SizedBox(width: w);
}
