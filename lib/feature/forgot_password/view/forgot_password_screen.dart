import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ForgotPasswordViewModel>(context);
    return Scaffold(
      appBar: AppbarTitleBackIconWidget(title: 'Reset Password'),
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: viewModel.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVertical(40),
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          ImageConst.logo,
                          height: 50,
                          width: 50,
                        ),
                        addVertical(16),
                        Text(
                          "Dental Interface",
                          style: TextStyles.clashSemiBold(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  addVertical(60),
                  InputTextField(
                    title: 'Email Address',
                    controller: viewModel.emailController,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  addVertical(10),
                  richText(),
                  addVertical(40),
                  AppButton(
                    height: 50,
                    onTap: () async {
                      if (viewModel.formKey.currentState!.validate()) {
                        viewModel.forgotPassword(context);
                      }
                    },
                    text: "Reset Password",
                  ),
                ],
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
          text: 'Continue to ',
          style: TextStyles.dmsansLight(
              color: color1 ?? AppColors.lightGeryColor, fontSize: 16),
          children: [
        TextSpan(
            text: 'Login',
            style: TextStyles.semiBold(
                color: color2 ?? AppColors.buttonColor,
                fontSize: 16,
                decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigationService.goBack();
              })
      ]));
}
