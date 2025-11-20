import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfessionalContactInfo extends StatelessWidget with BaseContextHelpers {
  const ProfessionalContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final viewProfileVM = Provider.of<ViewProfileViewModel>(context);

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          InputTextField(
              controller: viewProfileVM.addressController,
              hintText: "Address",
              title: "Address",
              validator:(v) {
                if (v!.isEmpty) {
                  return "Please enter address";
                } else {
                  return null;
                }
              },),
          addVertical(10),
          InputTextField(
              controller: viewProfileVM.addressLineOneController,
              hintText: "Address Line 1",
              title: "Address Line 1",
              readOnly: true),
          addVertical(10),
          InputTextField(
              controller: viewProfileVM.addressLineTwoController,
              hintText: "Address Line 2",
              title: "Address Line 2",
              readOnly: true),
          addVertical(10),
          InputTextField(
              controller: viewProfileVM.cityController,
              hintText: "City",
              title: "City",
              readOnly: true),
          addVertical(10),
          InputTextField(
              controller: viewProfileVM.landmarkController,
              hintText: "Landmark",
              title: "Landmark",
              readOnly: true),
          addVertical(10),
          InputTextField(
              controller: viewProfileVM.countryController,
              hintText: "Country",
              title: "Country",
              readOnly: true),
          addVertical(10),
          InputTextField(
              controller: viewProfileVM.stateController,
              hintText: "State",
              title: "State",
              readOnly: true),
          addVertical(10),
          InputTextField(
              controller: viewProfileVM.zipCodeController,
              hintText: "Enter post code",
              title: "Post Code",
              readOnly: true),
          addVertical(10)
        ]));
  }
}
