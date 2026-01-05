import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/campaign/view_model/campaign_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_multi_select_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_time_picker.dart';
import 'package:di360_flutter/feature/campaign/widgets/counts_container.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/radio_button_group.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCampaignView extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  CreateCampaignView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CampaignViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          surfaceTintColor: AppColors.whiteColor,
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InputTextField(
                    controller: viewModel.campaignNameController,
                    hintText: "Enter Campaign name",
                    title: "Campaign Name",
                    maxLength: 100,
                    readOnly: viewModel.repeatMode,
                    validator: validationCampaignName,
                  ),
                  addVertical(10),
                  CustomDatePicker(
                    validator: validateScheduleDate,
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
                        viewModel.setScheduleDate(picked);
                      }
                    },
                  ),
                  addVertical(10),
                  CustomTimePicker(
                    controller: viewModel.scheduleTimeController,
                    title: "Schedule Time",
                    isRequired: true,
                    onTap: () async {
                      final now = DateTime.now();
                      final selectedDate = viewModel.scheduledDate;
                      final isToday = selectedDate.year == now.year && 
                                     selectedDate.month == now.month && 
                                     selectedDate.day == now.day;
                      
                      final initialTime = isToday 
                          ? TimeOfDay.fromDateTime(now.add(Duration(minutes: 1)))
                          : TimeOfDay(hour: 9, minute: 0);
                      
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: initialTime,
                      );
                      
                      if (picked != null) {
                        if (isToday) {
                          final selectedDateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            picked.hour,
                            picked.minute,
                          );
                          
                          if (selectedDateTime.isBefore(now)) {
                            scaffoldMessenger('Please select a future time for today');
                            return;
                          }
                        }
                        
                        viewModel.scheduleTimeController.text = picked.format(context);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please Select Schedule Time';

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
                    direction: Axis.vertical,
                    readOnly: viewModel.repeatMode,
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
                      : SizedBox.shrink(),
                  CountsContainer(
                    type: viewModel.selectedType,
                    recipientsCount: viewModel.recipientsCount,
                    emailsCount: viewModel.selectedSendChips.length.toString(),
                    totalsCount: viewModel.selectedSendChips.length.toString(),
                  ),
                  addVertical(10),
                  InputTextField(
                    hintText: "Message type here.....",
                    maxLength: 160,
                    maxLines: 5,
                    title: "Message Composer",
                    controller: viewModel.messageController,
                    isRequired: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter message';
                      }
                    },
                  ),
                  addVertical(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRoundedButton(
                        text: 'Cancel',
                        onPressed: () {
                          navigationService.goBack();
                        },
                        height: 42,
                        backgroundColor: AppColors.geryColor,
                        textColor: Colors.black,
                      ),
                      CustomRoundedButton(
                        text: 'Save',
                        onPressed: () => _validateAndSave(context, viewModel),
                        height: 42,
                        backgroundColor: AppColors.primaryColor,
                        textColor: Colors.white,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _validateAndSave(BuildContext context, CampaignViewModel viewModel) {
    if (_formKey.currentState!.validate()) {
      if (viewModel.selectedGroupChips.isEmpty) {
        scaffoldMessenger('Please select at least one group');
        return;
      }
      if (viewModel.selectStateCondition.isEmpty) {
        scaffoldMessenger('Please select refine by state option');
        return;
      }
      if (viewModel.selectedType.isEmpty) {
        scaffoldMessenger('Please select campaign type');
        return;
      }
      if (viewModel.selectedSendChips.isEmpty) {
        scaffoldMessenger('Please select recipients');
        return;
      }
      viewModel.createCampaign(context);
    }
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _buildTimeZones(CampaignViewModel viewModel) {
    final validRoles = viewModel.timeOptions;

    final selectedValue = validRoles.contains(viewModel.selectedTimeZone)
        ? viewModel.selectedTimeZone
        : null;

    return CustomDropDown(
      isRequired: true,
      value: selectedValue,
      title: "Time Zone",
      onChanged: (v) {
        viewModel.setSelectedTimeZone(v as String);
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
      readOnly: viewModel.repeatMode,
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
          readOnly: viewModel.repeatMode,
          onSelectionChanged: (selected) {
            final current = List<String>.from(viewModel.selectedGroupChips);
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
            viewModel.getContacts();
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
          readOnly: viewModel.repeatMode,
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
          readOnly: viewModel.repeatMode,
          height: 50,
          items: viewModel.sendOptions,
          selectedItems: viewModel.selectedSendChips,
          itemLabel: (item) => item,
          hintText: "Select",
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
