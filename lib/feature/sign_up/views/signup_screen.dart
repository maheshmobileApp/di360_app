import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/sign_up/view_model/signup_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignupViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
              onPressed: () {
                navigationService.goBack();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.black,
              )),
          centerTitle: true,
          title: Text(
            "Sign Up",
            style: TextStyles.clashSemiBold(color: AppColors.black),
          )),
      body: Form(
        key: viewModel.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: getSize(context).height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    addVertical(25),
                    Center(
                        child: SvgPicture.asset(
                      ImageConst.logo,
                      height: 50,
                      width: 50,
                    )),
                    addVertical(10),
                    Text("Dental Interface",
                        style:
                            TextStyles.clashSemiBold(color: AppColors.black)),
                    Text("Create your account to start your journey.",
                        style: TextStyles.regular3(color: AppColors.black)),
                    addVertical(25),
                    InputTextField(
                        title: 'Full name',
                        controller: viewModel.nameController,
                        hintText: "Enter your name",
                        keyboardType: TextInputType.emailAddress,
                        validator: validateName),
                    addVertical(16),
                    InputTextField(
                        title: 'Email Id',
                        controller: viewModel.emailController,
                        hintText: "Email Id",
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail),
                    addVertical(16),
                    InputTextField(
                      title: 'Password',
                      controller: viewModel.passController,
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
                    addVertical(16),
                    InputTextField(
                      title: 'Confirm password',
                      controller: viewModel.conformController,
                      hintText: "Confirm password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != viewModel.passController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      obsecureText: !viewModel.isConformPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          viewModel.isConformPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.lightGeryColor,
                        ),
                        onPressed: viewModel.toggleConformPasswordVisibility,
                      ),
                    ),
                    addVertical(80),
                    Center(
                      child: AppButton(
                        onTap: () {
                          if (viewModel.formKey.currentState!.validate()) {
                            viewModel.selectedCategorys = null;
                            viewModel.businessType();
                          }
                        },
                        text: "Create new account",
                      ),
                    ),
                    addVertical(40),
                    richText(),
                    addVertical(50),
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

richText({Color? color1, Color? color2}) {
  return RichText(
      text: TextSpan(
          text: 'Already have an account? ',
          style: TextStyles.dmsansLight(
              color: color1 ?? AppColors.lightGeryColor, fontSize: 16),
          children: [
        TextSpan(
            text: 'Sign in',
            style: TextStyles.semiBold(
                color: color2 ?? AppColors.buttonColor,
                fontSize: 16,
                decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigationService.navigateTo(RouteList.login);
              })
      ]));
}
