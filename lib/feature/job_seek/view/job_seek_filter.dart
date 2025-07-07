import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';

class JobSeekFilterScreen extends StatelessWidget with BaseContextHelpers {
  const JobSeekFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<JobSeekViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.buttomBarColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: const Text(
          "Filter Jobs",
          style: TextStyle(fontSize: 20, color: AppColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            addVertical(16),
            buildSearchBar(model, context),
            Expanded(
              child: SingleChildScrollView(
                child: buildFilters(context, model),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomRoundedButton(
                      text: 'Clear',
                      fontSize: 12,
                      height: 42,
                      onPressed: () async {
                        model.clearSelections();
                        model.fetchJobs();
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
                      fontSize: 12,
                      height: 42,
                      onPressed: () async {
                        model.printSelectedItems();
                        model.fetchJobs();
                        navigationService.goBack();
                      },
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildSearchBar(JobSeekViewModel model, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: AppColors.whiteColor,
      ),
      child: Column(
        children: [
          addVertical(14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: model.searchController,
                    onFieldSubmitted: (_) async {
                      await model.fetchJobs();
                      navigationService.goBack();
                    },
                    decoration: InputDecoration(
                      hintText: 'What are you looking for?',
                      hintStyle: TextStyles.dmsansLight(
                        color: AppColors.black,
                        fontSize: 18,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          if (model.searchController.text.isNotEmpty) {
                            await model.fetchJobs();
                            navigationService.goBack();
                          }
                        },
                        child: const Icon(Icons.search, color: AppColors.black),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                addHorizontal(10),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.black,
                  child: SvgPicture.asset(
                    ImageConst.filter,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilters(BuildContext context, JobSeekViewModel model) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _filterSection(
              title: 'Filter by Location',
              options: const [],
              selected: const [],
              onToggle: (_) {},
              child: _locationSearchBar(model),
            ),
            _filterSection(
              title: 'Filter by Profession',
              options: model.professionOptions,
              selected: model.selectedProfessions,
              onToggle: model.toggleProfession,
            ),
            _filterSection(
              title: 'Filter by Employment Type',
              options: model.employmentOptions,
              selected: model.selectedEmploymentChips,
              onToggle: model.toggleEmploymentFilter,
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
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: model.selectedExperience,
                onChanged: (val) {
                  if (val != null) model.setExperience(val);
                },
              ),
            ),
            _filterSectionWithDropdown(
              title: 'Sort By Alphabetical Order',
              child: CustomDropDown<String>(
                title: '',
                hintText: 'Select Sort Order',
                items: model.sortOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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

  Widget _locationSearchBar(JobSeekViewModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(height: 0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.black.withOpacity(0.2)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: model.locationController,
                  decoration: const InputDecoration(
                    hintText: 'Search Location',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, size: 22),
                onPressed: () {
                  
                },
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}


  Widget _filterSection({
  required String title,
  required List<String> options,
  required List<String> selected,
  required Function(String) onToggle,
  Widget? child,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(height: 0), 
      Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            title,
            style: TextStyles.dmsansLight(
              color: AppColors.black,
              fontSize: 18,
            ),
          ),
          initiallyExpanded: true,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            if (options.isNotEmpty)
              ...options.map(
                (opt) => CheckboxListTile(
                  title: Text(opt),
                  value: selected.contains(opt),
                  onChanged: (_) => onToggle(opt),
                  activeColor: AppColors.primaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
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
      const Divider(height: 0), // Top border
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
            style: TextStyles.dmsansLight(
              color: AppColors.black,
              fontSize: 18,
            ),
          ),
          trailing: const Icon(Icons.expand_more),
          initiallyExpanded: true,
          childrenPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 0, 
            bottom: 8, 
          ),
          children: [
            child,
          ],
        ),
      ),
    ],
  );
}



  Widget _locumDateSection(BuildContext context, JobSeekViewModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          'Availability Date',
          style: TextStyles.dmsansLight(
            color: AppColors.black,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 250,
            child: CustomDatePicker(
              controller: model.locumDateController,
              hintText: "Choose locum dates",
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  model.locumDateController.text =
                      DateFormat('yyyy-MM-dd').format(date);
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}

}
