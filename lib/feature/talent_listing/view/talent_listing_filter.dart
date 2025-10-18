import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TalentListingFilter extends StatelessWidget with BaseContextHelpers {
  const TalentListingFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TalentListingViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarTitleBackIconWidget(title: 'Filter Talents'),
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
                        navigationService.goBack();
                      },
                      backgroundColor: AppColors.timeBgColor,
                      textColor: Colors.black,
                    ),
                  ),
                  addHorizontal(16),
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

  Widget buildFilters(BuildContext context, TalentListingViewModel model) {
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
              _filterSectionWithDropdown(
                title: 'Filter by Role',
                child: CustomDropDown<String>(
                  title: '',
                  hintText: 'Search Role',
                  items: model.roleOptions
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyles.regular3(
                                  color: AppColors.lightGeryColor),
                            ),
                          ))
                      .toList(),
                  value: model.selectedRole,
                  onChanged: (val) {
                    if (val != null) model.setRole(val);
                  },
                ),
              ),
              _filterSectionWithDropdown(
                title: 'Filter by Employment Type',
                child: CustomDropDown<String>(
                  title: '',
                  hintText: 'Search Employment Type',
                  items: model.employmentTypeOptions
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyles.regular3(
                                  color: AppColors.lightGeryColor),
                            ),
                          ))
                      .toList(),
                  value: model.selectedEmploymentType,
                  onChanged: (val) {
                    if (val != null) model.setEmploymentType(val);
                  },
                ),
              ),
              _filterSectionWithDropdown(
                title: 'Filter by Status',
                child: CustomDropDown<String>(
                  title: '',
                  hintText: 'Search Status',
                  items: model.StatusOptions.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: TextStyles.regular3(
                              color: AppColors.lightGeryColor),
                        ),
                      )).toList(),
                  value: model.selectedState,
                  onChanged: (val) {
                    if (val != null) model.setState(val);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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
            children: [child],
          ),
        ),
      ],
    );
  }
}
