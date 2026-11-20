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

class TransactionFilterView extends StatelessWidget with BaseContextHelpers {
  const TransactionFilterView({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CourseListingViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.buttomBarColor,
        appBar: AppbarTitleBackIconWidget(title: 'Filter Transactions'),
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
                                  viewModel.transactionSearchController,
                              hintText: "Search transaction",
                              title: "",
                              maxLength: 100,
                            ),
                            SizedBox(height: 8),
                            _buildStatus(viewModel),
                            SizedBox(height: 8),
                            CustomDatePicker(
                              title: "Date From",
                              controller: viewModel.dateFromController,
                              text: null,
                              hintText: "Date",
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2025),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  viewModel.dateFromController.text =
                                      DateFormat("dd/MM/yyyy").format(picked);
                                  viewModel.dateToController.text = "";
                                }
                              },
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please Select Date'
                                      : null,
                            ),
                            SizedBox(height: 8),
                            CustomDatePicker(
                              title: "Date To",
                              controller: viewModel.dateToController,
                              text: null,
                              hintText: "Date",
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: viewModel
                                          .dateFromController.text.isNotEmpty
                                      ? DateFormat("dd/MM/yyyy").parse(
                                          viewModel.dateFromController.text)
                                      : DateTime.now(),
                                  firstDate: viewModel
                                          .dateFromController.text.isNotEmpty
                                      ? DateFormat("dd/MM/yyyy").parse(
                                          viewModel.dateFromController.text)
                                      : DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  viewModel.dateToController.text =
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
                          viewModel.setTransactionApplyFilter(false);
                          viewModel.clearTransactionFilters();
                          await viewModel.getTransactions(
                              context, viewModel.selectedCourseId);
                          navigationService.goBack();
                        },
                      ),
                      AppButton(
                        text: 'Apply',
                        height: 40,
                        width: 150,
                        onTap: () async {
                          viewModel.setTransactionApplyFilter(true);
                          await viewModel.getTransactions(
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
    final uniqueStates = viewModel.transactionStatus.toSet().toList();

    return CustomDropDown(
      value: uniqueStates.contains(viewModel.selectedTransactionStatus)
          ? viewModel.selectedTransactionStatus
          : null,
      title: "Filter by Status",
      onChanged: (v) {
        viewModel.setSelectedTransactionStatus(v as String);
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
}
