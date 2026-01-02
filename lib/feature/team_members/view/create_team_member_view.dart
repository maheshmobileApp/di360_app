import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_multi_select_dropdown.dart';
import 'package:di360_flutter/feature/team_members/view_model/team_members_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTeamMemberView extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  CreateTeamMemberView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TeamMembersViewModel>(context);
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
            "Create Team Members",
            style: TextStyles.medium2(),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InputTextField(
                    controller: viewModel.userNameController,
                    hintText: "Enter User name",
                    title: "User Name",
                    isRequired: true,
                    maxLength: 100,
                    validator: validateName,
                  ),
                  addVertical(10),
                  InputTextField(
                      title: 'Email Id',
                      isRequired: true,
                      controller: viewModel.emailController,
                      hintText: "Email Id",
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail),
                  addVertical(10),
                  InputTextField(
                    controller: viewModel.phoneController,
                    hintText: "Enter Phone number",
                    isRequired: true,
                    title: "Phone",
                    maxLength: 10,
                    validator: validatePhoneNumber,
                  ),
                  addVertical(10),
                  InputTextField(
                    title: 'Password',
                    isRequired: true,
                    controller: viewModel.passwordController,
                    hintText: "Password",
                    validator: validatePassword,
                    obsecureText: !viewModel.isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewModel.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.lightGeryColor,
                      ),
                      onPressed: viewModel.togglePasswordVisibility,
                    ),
                  ),
                  addVertical(10),
                  InputTextField(
                    title: 'Confirm Password',
                    isRequired: true,
                    controller: viewModel.confirmPasswordController,
                    hintText: "Enter Confirm Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm password';
                      }
                      if (value != viewModel.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obsecureText: !viewModel.isConfirmPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewModel.isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.lightGeryColor,
                      ),
                      onPressed: viewModel.toggleConfirmPasswordVisibility,
                    ),
                  ),
                  addVertical(10),
                  _sectionHeader("Permission to Modules"),
                  Text(
                    "Permission to Modules",
                    style: TextStyles.regular3(color: AppColors.black),
                  ),
                  addVertical(4),
                  _buildPermissions(viewModel),
                  AppButton(
                    text: viewModel.editMode ? "Update":"Save",
                    height: 50,
                    onTap: () => _validateAndSave(context, viewModel),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _validateAndSave(BuildContext context, TeamMembersViewModel viewModel) {
    if (_formKey.currentState!.validate()) {
      if (viewModel.passwordController.text !=
          viewModel.confirmPasswordController.text) {
        scaffoldMessenger('Passwords do not match');
        return;
      }
      if (viewModel.selectedPermissionChips.isEmpty) {
        scaffoldMessenger('Please select at least one permission');
        return;
      }
     viewModel.editMode
          ? viewModel.updateTeamMember(context)
          : viewModel.createTeamMember(context);
    }
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _buildPermissions(TeamMembersViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomMultiSelectDropDown<String>(
          height: 50,
          items: viewModel.permissionOptions,
          selectedItems: viewModel.selectedPermissionChips,
          itemLabel: (item) => item,
          hintText: "Select Permissions",
          onSelectionChanged: (selected) {
            final current =
                List<String>.from(viewModel.selectedPermissionChips);
            for (final emp in current) {
              if (!selected.contains(emp)) {
                viewModel.removePermissionTypeChip(emp);
              }
            }
            for (final emp in selected) {
              if (!current.contains(emp)) {
                viewModel.addPermissionTypeChip(emp);
              }
            }
          },
        ),
        addVertical(16),
      ],
    );
  }
}
