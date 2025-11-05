import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewProfileVM = Provider.of<ViewProfileViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dou you want to sell supplies", style: TextStyles.regular3()),
              Row(
                children: [
                  _radioButton("Yes", true, viewProfileVM.isSuupliesSell,
                      (_) => viewProfileVM.toggleSupplies(true)),
                  _radioButton("No", false, viewProfileVM.isSuupliesSell,
                      (_) => viewProfileVM.toggleSupplies(false)),
                ],
              ),
              SizedBox(
              height: 8,
            ),
              Text("Dou you want to sell 2nd Hand supplies", style: TextStyles.regular3()),
              Row(
                children: [
                  _radioButton("Yes", true, viewProfileVM.isSecondHandSuupliesSell,
                      (_) => viewProfileVM.toggleSecondHandSupplies(true)),
                  _radioButton("No", false, viewProfileVM.isSecondHandSuupliesSell,
                      (_) => viewProfileVM.toggleSecondHandSupplies(false)),
                ],
              ),
              SizedBox(
              height: 8,
            ),
            Text(
              "-- Bank Details --",
              style: TextStyles.clashMedium(color: AppColors.buttonColor),
            ),
            InputTextField(
              controller: viewProfileVM.bankNameController,
              hintText: "Bank Name",
              title: "Bank Name",
            ),
            SizedBox(
              height: 8,
            ),
            InputTextField(
              controller: viewProfileVM.accountHolderNameController,
              hintText: "Account Holder Name",
              title: "Account Holder Name",
            ),
            SizedBox(
              height: 8,
            ),
            InputTextField(
              controller: viewProfileVM.accountNumberController,
              hintText: "Account Number",
              title: "Account Number",
            ),
            SizedBox(
              height: 8,
            ),
            InputTextField(
              controller: viewProfileVM.bsbController,
              hintText: "BSB",
              title: "BSB",
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _radioButton(String label, bool value, bool groupValue,
      ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<bool>(
          visualDensity: VisualDensity.compact,
          value: value,
          activeColor: AppColors.primaryColor,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(label, style: TextStyles.regular2()),
         SizedBox(width: 20,),
      ],
    );
  }
}
