import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                title: "Name",
                isRequired: true,
                validator: validateName),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.emailController,
                hintText: "Email",
                readOnly: true,
                isRequired: true,
                title: "Email",
                validator: validateEmail),
            addVertical(10),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 125,
                    child: CustomDropDown(
                      value: viewProfileVM.countryCode,
                      title: "Phone Number",
                      onChanged: (v) => viewProfileVM.setCountry(v!),
                      items: [
                        DropdownMenuItem(value: '+61', child: Text('AU (+61)')),
                        DropdownMenuItem(value: '+64', child: Text('NZ (+64)')),
                      ],
                      hintText: "Select category",
                      isRequired: true,
                    ),
                  ),
                  addHorizontal(5),
                  Expanded(
                    child: TextField(
                      controller: viewProfileVM.phoneNoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(9),
                      ],
                      decoration: InputDecoration(
                          hintText: 'Enter phone number',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 12, 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: AppColors.HINT_COLOR,
                            ),
                          )),
                      onChanged: (value) {
                        viewProfileVM.setNumber(value);
                      },
                    ),
                  )
                ])
          ],
        ));
  }
}
