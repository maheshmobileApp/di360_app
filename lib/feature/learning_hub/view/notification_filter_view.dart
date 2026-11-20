import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';

class NotificationFilterView extends StatelessWidget with BaseContextHelpers {
  const NotificationFilterView({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CourseListingViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.buttomBarColor,
        appBar: AppbarTitleBackIconWidget(title: 'Filter Notifications'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
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
                            InputTextField(
                              controller:
                                  viewModel.notificationSerachController,
                              hintText: "Search campaign",
                              title: "",
                              maxLength: 100,
                            ),
                            SizedBox(height: 8),
                            _buildStatus(viewModel),
                            SizedBox(height: 8),
                            _buildTypes(viewModel),
                            SizedBox(height: 8),
                            CustomDatePicker(
                              title: "Schedule From",
                              controller: viewModel.scheduleFromController,
                              text: null,
                              hintText: "Date",
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  viewModel.scheduleFromController.text =
                                      DateFormat("dd/MM/yyyy").format(picked);
                                  viewModel.scheduleToController.text = "";
                                }
                              },
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please Select Date'
                                      : null,
                            ),
                            SizedBox(height: 8),
                            CustomDatePicker(
                              title: "Schedule To",
                              controller: viewModel.scheduleToController,
                              text: null,
                              hintText: "Date",
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: viewModel.scheduleFromController
                                          .text.isNotEmpty
                                      ? DateFormat("dd/MM/yyyy").parse(
                                          viewModel.scheduleFromController.text)
                                      : DateTime.now(),
                                  firstDate: viewModel.scheduleFromController
                                          .text.isNotEmpty
                                      ? DateFormat("dd/MM/yyyy").parse(
                                          viewModel.scheduleFromController.text)
                                      : DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  viewModel.scheduleToController.text =
                                      DateFormat("dd/MM/yyyy").format(picked);
                                }
                              },
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please Select Date'
                                      : null,
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
                           viewModel.setApplyFilter(false);
                          viewModel.clearNotificationFilters();
                          await viewModel.notificationCampaigns(
                              context, viewModel.selectedCourseId);
                          navigationService.goBack();
                        },
                      ),
                      AppButton(
                        text: 'Apply',
                        height: 40,
                        width: 150,
                        onTap: () async {
                          viewModel.setApplyFilter(true);
                          await viewModel.notificationCampaigns(
                              context, viewModel.selectedCourseId);
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

  Widget _buildStatus(CourseListingViewModel viewModel) {
    // Remove duplicates from contactTypes
    final uniqueStates = viewModel.filterStatus.toSet().toList();

    return CustomDropDown(
      value: uniqueStates.contains(viewModel.selectedFilterStatus)
          ? viewModel.selectedFilterStatus
          : null,
      title: "Filter by Status",
      onChanged: (v) {
        viewModel.setSelectedFilterStatus(v as String);
      },
      items: uniqueStates.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Status",
    );
  }

  Widget _buildTypes(CourseListingViewModel viewModel) {
    final uniqueContactTypes = viewModel.filterType.toSet().toList();

    return CustomDropDown(
      value: uniqueContactTypes.contains(viewModel.selectedFilterType)
          ? viewModel.selectedFilterType
          : null,
      title: "Filter by Contact Type",
      onChanged: (v) {
        viewModel.setSelectedFilterContactType(v as String);
      },
      items: uniqueContactTypes.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Contact Type",
    );
  }
}
