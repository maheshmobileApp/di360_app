import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/address_type_radio_button.dart';
import 'package:di360_flutter/feature/supplies/widgets/app_button.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewsAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add New Address",
            style: TextStyles.medium2(),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AddressTypeRadioWidget(
                selectedAddressType: vm.addressType,
                onChanged: vm.setAddressType,
              ),
              if (vm.addressType == "Other")
                InputTextField(
                  controller: vm.otherTypeController,
                  hintText: "Enter other type",
                  keyboardType: TextInputType.name,
                  title: "Other Type",
                  maxLength: 70,
                  isRequired: true,
                ),
              InputTextField(
                controller: vm.locationController,
                hintText: "Enter location",
                keyboardType: TextInputType.name,
                title: "Location",
                maxLength: 70,
                isRequired: true,
              ),
              InputTextField(
                controller: vm.nameController,
                hintText: "Enter name",
                keyboardType: TextInputType.name,
                title: "Name",
                maxLength: 70,
                isRequired: true,
              ),
              InputTextField(
                controller: vm.addressline1Controller,
                hintText: "Enter address line 1",
                keyboardType: TextInputType.name,
                title: "Address Line 1",
                maxLength: 70,
                isRequired: true,
              ),
              InputTextField(
                controller: vm.addressline2Controller,
                hintText: "Enter address line 2",
                keyboardType: TextInputType.name,
                title: "Address Line 2",
                maxLength: 70,
                isRequired: true,
              ),
              InputTextField(
                controller: vm.landmarkController,
                hintText: "Enter Landmark",
                keyboardType: TextInputType.name,
                title: "Landmark",
                maxLength: 70,
                isRequired: true,
              ),
              InputTextField(
                controller: vm.cityController,
                hintText: "Enter city",
                keyboardType: TextInputType.name,
                title: "City",
                maxLength: 70,
                isRequired: true,
              ),
              _buildStates(vm),
              _buildCountry(vm),
              InputTextField(
                controller: vm.postcodeController,
                hintText: "Enter pincode",
                keyboardType: TextInputType.name,
                title: "Pincode",
                maxLength: 70,
                isRequired: true,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomRoundedButton(
                      text: 'Cancel',
                      height: 40,
                      backgroundColor: AppColors.timeBgColor,
                      textColor: AppColors.primaryColor,
                      onPressed: () {
                        navigationService.goBack();
                        vm.clearAddressFields();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AppButton(
                        borderRadius: 30,
                        height: 40,
                        title: "Save",
                        onPressed: () async {
                          await vm.addAddress(context);
                        }),
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  Widget _buildStates(SuppliesViewModel viewModel) {
    // Remove duplicates from contactTypes
    final uniqueStates = viewModel.filterStates.toSet().toList();

    return CustomDropDown(
      value: uniqueStates.contains(viewModel.selectedState)
          ? viewModel.selectedState
          : null,
      title: "Select State",
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

  Widget _buildCountry(SuppliesViewModel viewModel) {
    // Remove duplicates from contactTypes
    final uniqueCountry = viewModel.filterCountry.toSet().toList();

    return CustomDropDown(
      value: uniqueCountry.contains(viewModel.selectedCountry)
          ? viewModel.selectedCountry
          : null,
      title: "Select Country",
      onChanged: (v) {
        viewModel.setSelectedCountry(v as String);
      },
      items: uniqueCountry.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Country",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select country'
          : null,
    );
  }
}
