import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/sign_up/view_model/signup_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PracticeDetailsScreen extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  PracticeDetailsScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignupViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: getSize(context).height,
                        ),
                        child: IntrinsicHeight(
                            child: Column(children: [
                          addVertical(50),
                          Center(
                              child: SvgPicture.asset(
                            ImageConst.logo,
                            height: 50,
                            width: 50,
                          )),
                          addVertical(10),
                          Text("Your practice details",
                              style: TextStyles.clashSemiBold(
                                  color: AppColors.black)),
                          Text("Dental professional details form",
                              style:
                                  TextStyles.regular3(color: AppColors.black)),
                          addVertical(25),
                          InputTextField(
                              title: 'Business Name',
                              controller: viewModel.businessController,
                              hintText: "Enter Business Name",
                              keyboardType: TextInputType.text,
                              validator: validateBusiness),
                          addVertical(16),
                          InputTextField(
                              title: 'Phone No',
                              controller: viewModel.numberController,
                              hintText: "Enter Phone number",
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\+?[0-9]*$')),
                              ],
                              maxLength: 12,
                              validator: validatePhoneNumber),
                          addVertical(16),
                          InputTextField(
                              title: 'State',
                              controller: viewModel.stateController,
                              hintText: "Enter state",
                              keyboardType: TextInputType.emailAddress,
                              validator: validateState),
                          addVertical(16),
                          InputTextField(
                            title: 'Post code',
                            controller: viewModel.postalCodeController,
                            hintText: "Enter post code",
                            validator: validatePostalCode,
                          ),
                          addVertical(16),
                          Row(
                            children: [
                              Checkbox(
                                value: viewModel.agreeToTerms,
                                onChanged: (value) =>
                                    viewModel.setAgreeToTerms(value ?? false),
                                activeColor: AppColors.primaryColor,
                              ),
                              Text('I agree to the Terms and Conditions',
                                  style: TextStyles.medium2(
                                    color: viewModel.agreeToTerms
                                        ? AppColors.primaryColor
                                        : AppColors.black,
                                  ))
                            ],
                          ),
                          const Spacer(),

                          /// Buttons
                          Row(children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  navigationService.goBack();
                                },
                                child: Text("Go Back"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                                child: AppButton(
                              text: 'Sumbit',
                              height: 44,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  if (viewModel.agreeToTerms) {
                                    viewModel.signUp(context);
                                  } else {
                                    scaffoldMessenger(
                                        'Select Terms and Conditions');
                                  }
                                }
                              },
                            ))
                          ]),
                          addVertical(20)
                        ])))))));
  }
}
