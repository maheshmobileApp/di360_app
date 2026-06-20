import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:di360_flutter/widgets/phone_prefix_drodown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartnershipCommunityRequestView extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  PartnershipCommunityRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final directorVM = Provider.of<DirectoryViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Form(
            key: directorVM.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Partnership Request",
                  style: TextStyles.clashMedium(color: AppColors.buttonColor),
                ),
                SizedBox(height: 8),
                InputTextField(
                  controller: directorVM.companyNameController,
                  hintText: "Enter Company Name",
                  title: "Company Name",
                  maxLength: 100,
                  readOnly: true,
                ),
                SizedBox(height: 8),
                InputTextField(
                  controller: directorVM.contactNameController,
                  hintText: "Enter Contact Name",
                  title: "Contact Name",
                  isRequired: true,
                  validator: validateContactName,
                  maxLength: 100,
                ),
                SizedBox(height: 8),
                InputTextField(
                  controller: directorVM.emailController,
                  hintText: "Enter Email",
                  title: "Email",
                  maxLength: 100,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return validateEmail(value);
                  },
                ),
                SizedBox(height: 8),
                InputTextField(
                  title: "Mobile Number",
                  isRequired: true,
                  hintText: "4XXXXXXXX",
                  keyboardType: TextInputType.phone,
                  maxLength: 9,
                  controller: directorVM.phoneController,
                  validator: validateAustralianMobileNumber,
                  prefixIcon: PhonePrefixDropdown(
                    value: directorVM.selectedPhoneCode ?? "",
                    items: directorVM.phoneCodeList,
                    onChanged: (value) {
                      directorVM.setPhoneCode(value ?? "");
                    },
                  ),
                ),
                SizedBox(height: 8),
                _buildStates(directorVM),
                SizedBox(
                  height: 30,
                ),
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
                          directorVM.clearCommunityFields();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                          height: 40,
                          text: 'Submit',
                          onTap: () {
                            if (!directorVM.validateForm()) return;

                            directorVM.partnershipRegsiter(
                                context,
                                directorVM.directorCommunityID ?? "",
                                directorVM.directorCommunityName ?? "",
                                directorVM.directorSupplierID ?? "");
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }

  Widget _buildStates(DirectoryViewModel viewModel) {
    return CustomDropDown(
      isRequired: true,
      value: viewModel.partnershipStatesList
              .any((e) => e["short"] == viewModel.selectedState)
          ? viewModel.selectedState
          : null,
      title: "State",
      onChanged: (v) {
        viewModel.setPartnershipSelectedState(v as String);
      },
      items:
          viewModel.partnershipStatesList.map<DropdownMenuItem<Object>>((item) {
        return DropdownMenuItem<Object>(
          value: item["short"],
          child: Text(item["name"]!),
        );
      }).toList(),
      hintText: "Select State",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select state'
          : null,
    );
  }
}
