import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';

class PromotionFilterView extends StatelessWidget with BaseContextHelpers {
  const PromotionFilterView({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CourseListingViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.buttomBarColor,
        appBar: AppbarTitleBackIconWidget(title: 'Filter Promotions'),
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
                              controller: viewModel.promoCodeController,
                              hintText: "Search promo code",
                              title: "",
                              maxLength: 100,
                            ),
                            SizedBox(height: 8),
                            _buildStatus(viewModel),
                            SizedBox(height: 8),
                            _buildTypes(viewModel),
                            SizedBox(height: 8),
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
                          viewModel.setPromotionApplyFilter(false);
                          viewModel.clearPromotionFilters();
                          await viewModel.coursePromotions(
                              context, viewModel.selectedCourseId);
                          navigationService.goBack();
                        },
                      ),
                      AppButton(
                        text: 'Apply',
                        height: 40,
                        width: 150,
                        onTap: () async {
                          viewModel.setPromotionApplyFilter(true);
                          await viewModel.coursePromotions(
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
    final uniqueStates = viewModel.promotionStatus.toSet().toList();

    return CustomDropDown(
      value: uniqueStates.contains(viewModel.selectedPromotionStatus)
          ? viewModel.selectedPromotionStatus
          : null,
      title: "Status",
      onChanged: (v) {
        viewModel.setSelectedPromotionStatus(v as String);
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
    final uniqueContactTypes = viewModel.discountType.toSet().toList();

    return CustomDropDown(
      value: uniqueContactTypes.contains(viewModel.selectedDiscountType)
          ? viewModel.selectedDiscountType
          : null,
      title: "Discount Type",
      onChanged: (v) {
        viewModel.setSelectedDiscountType(v as String);
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
