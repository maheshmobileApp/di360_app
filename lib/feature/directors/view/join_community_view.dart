import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/radio_button_group.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:di360_flutter/widgets/phone_prefix_drodown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JoinCommunityView extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  JoinCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DirectoryViewModel>(
      builder: (context, directorVM, child) {
        return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Join Community",
                      style:
                          TextStyles.clashMedium(color: AppColors.buttonColor),
                    ),
                    SizedBox(height: 8),
                    InputTextField(
                      controller: directorVM.firstNameController,
                      hintText: "Enter First Name",
                      title: "First Name",
                      readOnly: true,
                      maxLength: 100,
                    ),
                    SizedBox(height: 8),
                    InputTextField(
                      controller: directorVM.lastNameController,
                      hintText: "Enter Last Name",
                      title: "Last Name",
                      readOnly: true,
                      maxLength: 100,
                    ),
                    SizedBox(height: 8),
                    InputTextField(
                      controller: directorVM.emailController,
                      hintText: "Enter Email",
                      title: "Email",
                      maxLength: 100,
                      validator: validateEmail,
                    ),
                    SizedBox(height: 8),
                    InputTextField(
                    title: "Phone",
                    hintText: "Enter phone number",
                    keyboardType: TextInputType.phone,
                    maxLength: 9,
                    controller: directorVM.phoneController,
                    validator: validateContactPhoneNumber,
                    prefixIcon: PhonePrefixDropdown(
                      value: directorVM.selectedPhoneCode??"",
                      items: directorVM.phoneCodeList,
                      onChanged: (value) {
                        directorVM.setPhoneCode(value ?? "");
                      },
                    ),
                  ),
                   /* InputTextField(
                      controller: directorVM.phoneController,
                      hintText: "Enter Phone Number",
                      title: "Phone",
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      validator: validatePhoneNumber,
                    ),*/
                    SizedBox(height: 8),
                    _buildStates(directorVM),
                     SizedBox(height: 8),
                    CustomRadioGroup<String>(
                      title: "Do you have a membership number?",
                      options: const ["Yes", "No"],
                      selectedValue: directorVM.selectedMembership,
                      labelBuilder: (value) => value,
                      direction: Axis.vertical, // try Axis.vertical also
                      onChanged: (value) {
                        directorVM.setSelectedMembership(value);
                      },
                    ),
                    SizedBox(height: 8),
                    (directorVM.selectedMembership == "Yes")
                        ? InputTextField(
                            controller: directorVM.membershipNumberController,
                            hintText: "Enter membership number",
                            title: "Membership Number",
                            maxLength: 100,
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 30),
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
                              btnColor: directorVM.validateJoinCommunityFields()
                                  ? AppColors.primaryColor
                                  : AppColors.greysecond,
                              height: 40,
                              text: "Register Now",
                              onTap: () {
                                if (!directorVM.validateJoinCommunityFields()) return;
                                directorVM.selectedMembership == "Yes"
                                    ? directorVM.communityRegsiter(
                                        context,
                                        directorVM.directorCommunityID ?? "",
                                        directorVM.directorCommunityName ?? "",
                                        directorVM.directorSupplierID ?? "")
                                    : alertPopup(
                                        context,
                                        "You are being redirected to the registration link",
                                        onBack: () async {
                                          final url = Uri.parse(
                                            "https://docs.google.com/forms/d/1j__p12VOITVXFpxTYQVr8XCMhzp-b5QqaJo5Pc_mdW8/viewform?edit_requested=true",
                                          );
                                          if (!await launchUrl(url,
                                              mode: LaunchMode
                                                  .externalApplication)) {
                                            throw "Could not launch $url";
                                          }
                                        },
                                      );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget _buildStates(DirectoryViewModel viewModel) {
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
