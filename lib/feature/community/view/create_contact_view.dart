import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:di360_flutter/widgets/phone_prefix_drodown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateContactView extends StatefulWidget {
  @override
  _CreateCategoryViewState createState() => _CreateCategoryViewState();
}

class _CreateCategoryViewState extends State<CreateContactView>
    with ValidationMixins {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBarWidget(
           logo: false,
          title: (viewModel.contactEditMode) ? "Edit Contact":"Add Contact",
          searchWidget: false,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContactTypes(viewModel),
                  SizedBox(
                    height: 6,
                  ),
                  InputTextField(
                    title: "Phone",
                    hintText: "4XXXXXXXX",
                    keyboardType: TextInputType.phone,
                    maxLength: 9,
                    controller: viewModel.contactPhoneController,
                    validator: validateAustralianMobileNumber,
                    prefixIcon: PhonePrefixDropdown(
                      value: viewModel.selectedPhoneCode??"",
                      items: viewModel.phoneCodeList,
                      onChanged: (value) {
                        viewModel.setPhoneCode(value ?? "");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InputTextField(
                    controller: viewModel.contactNameController,
                    hintText: "Enter Contact Name",
                    title: "Contact Name",
                    maxLength: 100,
                    isRequired: true,
                    validator: validateContactName,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InputTextField(
                    controller: viewModel.contactEmailController,
                    hintText: "Enter Email Address",
                    title: "Email",
                    maxLength: 100,
                    isRequired: true,
                    validator: validateEmail,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  _buildStates(viewModel),
                  SizedBox(
                    height: 20,
                  ),
                  AppButton(
                    height: 42,
                    text: (viewModel.contactEditMode) ? "Update" : "Save",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                              (viewModel.contactEditMode)
                                  ? await viewModel.updateContact(
                                      context,viewModel.updateContactId)
                                  : await viewModel.addContact(context);
                            }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildContactTypes(CommunityViewModel viewModel) {
    return CustomDropDown(
      isRequired: true,
      value: viewModel.contactTypes.any((e) => e["value"] == viewModel.selectedContactType)
          ? viewModel.selectedContactType
          : null,
      title: "Category",
      onChanged: (v) {
        viewModel.setSelectedContactType(v as String);
      },
      items: viewModel.contactTypes.map<DropdownMenuItem<Object>>((item) {
        return DropdownMenuItem<Object>(
          value: item["value"],
          child: Text(item["label"]!),
        );
      }).toList(),
      hintText: "Select Contact Type",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select contact type'
          : null,
    );
  }

  Widget _buildStates(CommunityViewModel viewModel) {
    // Remove duplicates from contactTypes
    final uniqueStates = viewModel.states.toSet().toList();

    return CustomDropDown(
      isRequired: true,
      value: uniqueStates.contains(viewModel.selectedState)
          ? viewModel.selectedState
          : null,
      title: "State",
      onChanged: (v) {
        viewModel.setSelectedState(v as String);
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
}
