import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfessinoalBasicInfo extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  const ProfessinoalBasicInfo({super.key});
  @override
  Widget build(BuildContext context) {
    final viewProfileVM = context.read<ViewProfileViewModel>();

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputTextField(
                controller: viewProfileVM.nameController,
                hintText: "Name",
                title: "Contact Name",
                validator: validateName),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.emailController,
                hintText: "Email",
                readOnly: true,
                title: "Email",
                validator: validateEmail),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.phoneNoController,
                hintText: "Phone Number",
                title: "Phone Number",
                validator: validateEmptyPhoneNumber),
          ],
        ));
  }
}
