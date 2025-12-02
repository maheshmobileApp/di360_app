import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/radio_button_group.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinCommunityView extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  JoinCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final directorVM = Provider.of<DirectoryViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Join Community",
                style: TextStyles.clashMedium(color: AppColors.buttonColor),
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: directorVM.firstNameController,
                hintText: "Enter First Name",
                title: "First Name",
                maxLength: 100,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: directorVM.lastNameController,
                hintText: "Enter Last Name",
                title: "Last Name",
                maxLength: 100,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: directorVM.emailController,
                hintText: "Enter Email",
                title: "Email",
                maxLength: 100,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: directorVM.phoneController,
                hintText: "Enter Phone Number",
                title: "Phone",
                maxLength: 100,
              ),
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
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomRoundedButton(
                      text: 'Clear',
                      height: 40,
                      backgroundColor: AppColors.timeBgColor,
                      textColor: AppColors.primaryColor,
                      onPressed: () {
                        navigationService.goBack();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                        height: 40,
                        text: 'Register Now',
                        onTap: () {
                          directorVM.communityRegsiter(context);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
