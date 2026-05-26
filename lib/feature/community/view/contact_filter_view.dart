import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';

class ContactFilterView extends StatelessWidget with BaseContextHelpers {
  const ContactFilterView({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.buttomBarColor,
        appBar: AppbarTitleBackIconWidget(title: 'Filter Contacts'),
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
                            _buildStates(viewModel),
                            _buildContactTypes(viewModel)
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
                          viewModel.selectedFilterContactType = "";
                          viewModel.selectedFilterState = "";
                          await viewModel.getContacts(context);
                          navigationService.goBack();
                        },
                      ),
                      AppButton(
                        text: 'Apply',
                        height: 40,
                        width: 150,
                        onTap: () async {
                          await viewModel.getContacts(context);
                          viewModel.updateAppliedContactFilter(true);
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

  Widget _buildStates(CommunityViewModel viewModel) {
    // Remove duplicates from contactTypes
    final uniqueStates = viewModel.filterStates.toSet().toList();

    return CustomDropDown(
      value: uniqueStates.contains(viewModel.selectedFilterState)
          ? viewModel.selectedFilterState
          : null,
      title: "Filter by State",
      onChanged: (v) {
        viewModel.setSelectedFilterState(v as String);
      },
      items: uniqueStates.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select State",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select state'
          : null,
    );
  }

  Widget _buildContactTypes(CommunityViewModel viewModel) {
    // Remove duplicates from contactTypes
    final uniqueContactTypes = viewModel.filterContactTypes.toSet().toList();

    return CustomDropDown(
      value: uniqueContactTypes.contains(viewModel.selectedFilterContactType)
          ? viewModel.selectedFilterContactType
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
