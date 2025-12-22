import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartnershipCommunityRequestView extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  final _formKey = GlobalKey<FormState>();
  PartnershipCommunityRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final directorVM = Provider.of<DirectoryViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
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
                  maxLength: 100,
                  isRequired: true,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter contact name' : null,
                ),
                SizedBox(height: 8),
                InputTextField(
                  controller: directorVM.emailController,
                  hintText: "Enter Email",
                  title: "Email",
                  validator: validateEmail,
                  isRequired: true,
                ),
                SizedBox(height: 8),
                InputTextField(
                  controller: directorVM.phoneController,
                  hintText: "Enter Phone Number",
                  title: "Phone",
                  maxLength: 10,
                  validator: validatePhoneNumber,
                  isRequired: true,
                ),
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
                            if (_formKey.currentState!.validate()) {
                              directorVM.partnershipRegsiter(
                                  context,
                                  directorVM.directorCommunityID ?? "",
                                  directorVM.directorCommunityName ?? "",
                                  directorVM.directorSupplierID ?? "");
                            }
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
