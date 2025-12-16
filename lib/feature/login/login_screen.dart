import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/account/account_view_model/account_view_model.dart';
import 'package:di360_flutter/feature/login/login_view_model/login_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    final profileVM = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: viewModel.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              addVertical(70),
              Center(
                  child: SvgPicture.asset(
                ImageConst.logo,
                height: 50,
                width: 50,
              )),
              addVertical(10),
              Text(
                "Dental Interface",
                style: TextStyles.clashSemiBold(color: AppColors.black),
              ),
              addVertical(50),
              // DropDownTextField(
              //   items: viewModel.userTypeItems,
              //   onChanged: viewModel.onTypeChange,
              //   value: viewModel.userType,
              // ),
              addVertical(20),
              InputTextField(
                  title: 'Email Id',
                  controller: viewModel.emailController,
                  hintText: "Email Id",
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail),
              addVertical(20),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text("Forgot Password",
                          style: TextStyles.dmsansLight(
                              color: AppColors.lightGeryColor, fontSize: 16)))
                ],
              ),
              Spacer(),
              Center(
                child: AppButton(
                  onTap: () async {
                    if (viewModel.formKey.currentState!.validate()) {
                      await viewModel.submit(context);
                      final supplier = viewModel
                          .supplerCommunityOwner?.dentalSuppliers?.first;
                      print(
                          "Status***************************${supplier?.communityStatus}");
                      (supplier?.communityStatus == "YES")
                          ? profileVM.updateCommunityStatus(true)
                          : profileVM.updateCommunityStatus(false);
                    }
                  },
                  text: "Login",
                ),
              ),
              addVertical(40),
              richText(),
              addVertical(50),
            ],
          ),
        ),
      ),
    );
  }
}

richText({Color? color1, Color? color2}) {
  return RichText(
      text: TextSpan(
          text: 'Don’t have an account? ',
          style: TextStyles.dmsansLight(
              color: color1 ?? AppColors.lightGeryColor, fontSize: 16),
          children: [
        TextSpan(
            text: 'Sign up',
            style: TextStyles.semiBold(
                color: color2 ?? AppColors.buttonColor,
                fontSize: 16,
                decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigationService.navigateTo(RouteList.signup);
              })
      ]));
}
