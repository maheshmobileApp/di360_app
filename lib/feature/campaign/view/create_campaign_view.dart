import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/campaign/view_model/campaign_view_model.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_multi_select_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_time_picker.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/radio_button_group.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCampaignView extends StatelessWidget with BaseContextHelpers {
  CreateCampaignView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CampaignViewModel>(context);
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () {
              showAlertMessage(
                context,
                'You have unsaved changes. Do you want to discard them?',
                onBack: () async {
                  navigationService.goBack();
                  navigationService.goBack();
                },
              );
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Create New Campaign",
          style: TextStyles.medium2(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InputTextField(
                controller: viewModel.campaignNameController,
                hintText: "Enter Campaign name",
                title: "Campaign Name",
                maxLength: 100,
              ),
              addVertical(10),
              CustomDatePicker(
                controller: viewModel.scheduleDateController,
                title: "Scheduled Date",
                hintText: "Select scheduled date",
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    viewModel.setStartLocumDate(picked);
                  } else {
                    jobCreateVM.clearDates();
                  }
                },
              ),
              addVertical(10),
              CustomTimePicker(
                controller: viewModel.scheduleTimeController,
                title: "Schedule Time",
                isRequired: true,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please Select End Time';

                  return null;
                },
              ),
              addVertical(10),
              _buildTimeZones(viewModel),
              addVertical(10),
              Text(
                "Select Groups",
                style: TextStyles.regular3(color: AppColors.black),
              ),
              addVertical(4),
              _buildEmpTypes(viewModel),
              _buildTypes(viewModel),
              addVertical(10),
              CustomRadioGroup<String>(
                title: "Refine by State",
                isRequired: true,
                options: ['Yes', 'No'],
                selectedValue: viewModel.selectStateCondition,
                labelBuilder: (value) => value,
                direction: Axis.vertical, // try Axis.vertical also
                onChanged: (value) {
                  viewModel.setStateCondition(value);
                },
              ),
              (viewModel.selectStateCondition == 'Yes')
                  ? _buildStates(viewModel)
                  : SizedBox.shrink(),
              addVertical(10),
              (viewModel.selectedType != "")
                  ? _buildNumbersAndEmails(viewModel)
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _buildTimeZones(CampaignViewModel viewModel) {
    final validRoles = viewModel.timeOptions;

    final selectedValue = validRoles.contains(viewModel.selectedTime)
        ? viewModel.selectedTime
        : null;

    return CustomDropDown(
      isRequired: true,
      value: selectedValue,
      title: "Time Zone",
      onChanged: (v) {
        viewModel.setSelectedTime(v as String);
      },
      items: validRoles.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(
            value,
            maxLines: 2,
          ),
        );
      }).toList(),
      hintText: "Select Time Zone",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select Time Zone'
          : null,
    );
  }

  Widget _buildTypes(CampaignViewModel viewModel) {
    final validRoles = viewModel.typeOptions;

    final selectedValue = validRoles.contains(viewModel.selectedType)
        ? viewModel.selectedType
        : null;

    return CustomDropDown(
      isRequired: true,
      value: selectedValue,
      title: "Select Type",
      onChanged: (v) {
        viewModel.setSelectedType(v as String);
      },
      items: validRoles.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(
            value,
            maxLines: 2,
          ),
        );
      }).toList(),
      hintText: "Select Type",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select Type'
          : null,
    );
  }

  Widget _buildEmpTypes(CampaignViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomMultiSelectDropDown<String>(
          height: 50,
          items: viewModel.groupOptions,
          selectedItems: viewModel.selectedGroupChips,
          itemLabel: (item) => item,
          hintText: "Select Groups",
          onSelectionChanged: (selected) {
            final current =
                List<String>.from(viewModel.selectedGroupChips);
            for (final emp in current) {
              if (!selected.contains(emp)) {
                viewModel.removeGroupTypeChip(emp);
              }
            }
            for (final emp in selected) {
              if (!current.contains(emp)) {
                viewModel.addGroupTypeChip(emp);
              }
            }
            // Call API after selection is finalized
            viewModel.getStatesByGroups();
          },
        ),
        addVertical(16),
      ],
    );
  }

  Widget _buildStates(CampaignViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select State",
          style: TextStyles.regular3(color: AppColors.black),
        ),
        addVertical(6),
        CustomMultiSelectDropDown<String>(
          showOptions: true,
          height: 50,
          items: viewModel.stateOptions,
          selectedItems: viewModel.selectedStateChips,
          itemLabel: (item) => item,
          hintText: "Select State",
          onSelectionChanged: (selected) {
            final current = List<String>.from(viewModel.selectedStateChips);
            for (final emp in current) {
              if (!selected.contains(emp)) {
                viewModel.removeStateTypeChip(emp);
              }
            }
            for (final emp in selected) {
              if (!current.contains(emp)) {
                viewModel.addStateTypeChip(emp);
              }
            }
          },
        ),
        addVertical(16),
      ],
    );
  }

  Widget _buildNumbersAndEmails(CampaignViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewModel.selectedType == "SMS"
              ? "Send to Numbers"
              : "Send To Email Address",
          style: TextStyles.regular3(color: AppColors.black),
        ),
        addVertical(6),
        CustomMultiSelectDropDown<String>(
          showOptions: true,
          height: 50,
          items: viewModel.sendOptions,
          selectedItems: viewModel.selectedSendChips,
          itemLabel: (item) => item,
          hintText: "Select....",
          onSelectionChanged: (selected) {
            final current = List<String>.from(viewModel.selectedSendChips);
            for (final emp in current) {
              if (!selected.contains(emp)) {
                viewModel.removeSendTypeChip(emp);
              }
            }
            for (final emp in selected) {
              if (!current.contains(emp)) {
                viewModel.addSendTypeChip(emp);
              }
            }
          },
        ),
        addVertical(16),
      ],
    );
  }
}
