import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/sign_up/view_model/signup_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleSelectionScreen extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  RoleSelectionScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignupViewModel>(context);

    final businessTypes = viewModel.directoryBusinessTypes;
    final selectedIndex = viewModel.selectedIndex;

    final selectedBusiness = businessTypes?[selectedIndex];
    final excludedTypes = [
      "Dental Receptionist",
      "Dental Therapist",
      "Dental Assistant",
      "Dental Technician"
    ];
    final shouldShowAphra =
        !excludedTypes.contains(viewModel.selectedCategory?.name);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarTitleBackIconWidget(title: 'Know Your Role'),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: getSize(context).height),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "What's your ${viewModel.selectedType?['type'] == UserRole.professional.value ? 'Professional' : 'Business'} Type?",
                        textAlign: TextAlign.center,
                        style: TextStyles.bold3(color: AppColors.black)),
                    addVertical(10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            List.generate(businessTypes?.length ?? 0, (index) {
                          final type = businessTypes?[index];
                          final isSelected = index == selectedIndex;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Text(type?.name ?? ''),
                              selected: isSelected,
                              onSelected: (_) =>
                                  viewModel.setSelectedIndex(index),
                              selectedColor: AppColors.primaryColor,
                              backgroundColor: AppColors.geryColor,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    addVertical(16),
                    Text('Select Category *',
                        style: TextStyles.bold3(color: AppColors.black)),
                    addVertical(10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        selectedBusiness?.directoryCategories?.length ?? 0,
                        (index) {
                          final cat =
                              selectedBusiness?.directoryCategories?[index];
                          final isSelected =
                              viewModel.selectedCategory?.id == cat?.id;
                          return ChoiceChip(
                            label: Text(cat?.name ?? ''),
                            selected: isSelected,
                            onSelected: (_) => cat != null
                                ? viewModel.selectCategory(cat)
                                : null,
                            selectedColor: AppColors.primaryColor,
                            backgroundColor: AppColors.hintColor,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            shape: const StadiumBorder(
                              side: BorderSide(color: AppColors.primaryColor),
                            ),
                          );
                        },
                      ),
                    ),
                    addVertical(20),
                    InputTextField(
                        title: 'State',
                        controller: viewModel.stateController,
                        isRequired: true,
                        hintText: "Enter state",
                        keyboardType: TextInputType.text,
                        validator: validateState),
                    if (viewModel.selectedType?['type'] ==
                            UserRole.professional.value &&
                        shouldShowAphra) ...[
                      addVertical(20),
                      InputTextField(
                          controller: viewModel.ahpraRegistrationNumber,
                          hintText: "AHPRA Registration Number",
                          title: "AHPRA Registration Number",
                          validator: validateAphraNumber)
                    ],
                    if (viewModel.selectedType?['type'] ==
                            UserRole.supplier.value ||
                        viewModel.selectedType?['type'] ==
                            UserRole.practice.value) ...[
                      addVertical(20),
                      InputTextField(
                          controller: viewModel.abnNumber,
                          hintText: "ABN / ACN Number",
                          title: "ABN / ACN Number",
                          validator: validateABNNumber)
                    ],
                    Row(
                      children: [
                        Checkbox(
                          value: viewModel.agreeToTerms,
                          onChanged: (value) =>
                              viewModel.setAgreeToTerms(value ?? false),
                          activeColor: AppColors.primaryColor,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              navigationService
                                  .navigateTo(RouteList.termsAndConditionsDetails);
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'I agree to the ',
                                style: TextStyles.medium2(
                                  color: AppColors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    style: TextStyles.medium2(
                                      color: AppColors.primaryColor,
                                    ).copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => navigationService.goBack(),
                          child: Text("Go Back"),
                        ),
                      ),
                      addHorizontal(12),
                      Expanded(
                          child: AppButton(
                              text: 'Submit',
                              height: 48,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  if (viewModel.selectedCategory == null) {
                                    scaffoldMessenger('Please select category');
                                  } else if (viewModel.agreeToTerms == false) {
                                    scaffoldMessenger(
                                        'You must agree to the Terms and Conditions');
                                  } else {
                                    viewModel.signUp(context);
                                  }
                                }
                              }))
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
