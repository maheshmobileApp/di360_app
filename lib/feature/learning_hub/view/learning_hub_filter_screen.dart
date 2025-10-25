import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_seek/widget/collasible_section.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/learning_hub_master_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';

class LearningHubFilterScreen extends StatelessWidget with BaseContextHelpers {
  const LearningHubFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final model = Provider.of<JobSeekViewModel>(context);
    final newCourseVM = Provider.of<NewCourseViewModel>(context);
    final learningHubMasterVM =
        Provider.of<LearningHubMasterViewModel>(context);
    final courseListingVM = Provider.of<CourseListingViewModel>(context);

    // ✅ Initialize filter options (only once)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (learningHubMasterVM.filterOptions.isEmpty) {
        learningHubMasterVM.initializeFilters(
          typeList: newCourseVM.courseTypeNames,
          categoryList: newCourseVM.courseCategory,
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.buttomBarColor,
      appBar: AppbarTitleBackIconWidget(title: 'Filter Learning Hub'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              addVertical(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Filter by Type
                        _buildFilterSection(
                          context,
                          title: "Filter by Type",
                          options: newCourseVM.courseTypeNames,
                          selectedIndices:
                              learningHubMasterVM.selectedIndices['type'] ?? {},
                          onToggle: (index) =>
                              learningHubMasterVM.selectItem('type', index),
                        ),
                        const Divider(),

                        // Filter by Category
                        _buildFilterSection(
                          context,
                          title: "Filter by Category",
                          options: newCourseVM.courseCategory,
                          selectedIndices:
                              learningHubMasterVM.selectedIndices['category'] ??
                                  {},
                          onToggle: (index) =>
                              learningHubMasterVM.selectItem('category', index),
                        ),
                        const Divider(),

                        // Filter by Date
                        _buildDropdownSection(
                          title: "Filter by Date",
                          dropdown: CustomDatePicker(
                            title: "Date",
                            controller:
                                learningHubMasterVM.filterDateController,
                            hintText: "Date",
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100),
                              );

                              if (picked != null) {
                                learningHubMasterVM.filterDateController.text =
                                    DateFormat("dd/MM/yyyy").format(picked);
                              }
                            },
                          ),
                        ),
                        const Divider(),

                        // Filter by Location
                        _buildDropdownSection(
                          title: "Filter by Location",
                          dropdown: InputTextField(
                            title: "Location",
                            controller: learningHubMasterVM.locationController,
                            hintText: "Enter Location",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // --- Buttons ---
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
                        learningHubMasterVM.clearSelections();
                        await courseListingVM.getMarketPlaceCoursesWithFilters(
                          context,
                          "",
                          "",
                          "",
                          "",
                        );
                      },
                    ),
                    AppButton(
                      text: 'Apply',
                      height: 40,
                      width: 150,
                      onTap: () async {
                        await learningHubMasterVM.setSelectedCourseCategories(
                            learningHubMasterVM.selectedCategory);
                        await courseListingVM.getMarketPlaceCoursesWithFilters(
                          context,
                          learningHubMasterVM.selectedType.join(','),
                          learningHubMasterVM.selectedCategoryIds.join(','),
                          learningHubMasterVM.filterDateController.text,
                          learningHubMasterVM.locationController.text,
                        );
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
  }) {
    return CollapsibleSection(
      title: title,
      child: Column(
        children: List.generate(options.length, (index) {
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
      ),
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

  SizedBox addVertical(double h) => SizedBox(height: h);
}
