import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactInfo extends StatelessWidget with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final viewProfileVM = Provider.of<ViewProfileViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputTextField(
                controller: viewProfileVM.firstNameController,
                hintText: "First Name",
                title: "first Name",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.middleNameController,
                hintText: "Middle Name",
                title: "Middle Name",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.lastNameController,
                hintText: "Last Name",
                title: "Last Name",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.businessEmailController,
                hintText: "Business Email",
                title: "Business Email",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.faxNumberController,
                hintText: "Fax Number",
                title: "Fax Number",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.alternateEmailController,
                hintText: "Alternate Email",
                title: "Alternate Email",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.alternatePhoneNoController,
                hintText: "Alternate Phone Number",
                title: "Alternate Phone NUmber",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.addressController,
                hintText: "Address",
                title: "Address",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.addressLineOneController,
                hintText: "Address Line 1",
                title: "Address Line 1",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.addressLineTwoController,
                hintText: "Address Line 2",
                title: "Address Line 2",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.cityController,
                hintText: "City",
                title: "City",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.landmarkController,
                hintText: "Landmark",
                title: "Landmark",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.countryController,
                hintText: "Country",
                title: "Country",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.stateController,
                hintText: "State",
                title: "State",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.zipCodeController,
                hintText: "Zip Code",
                title: "Zip Code",
              ),
              addVertical(10),
              Text(
                "-- Secondary Contact Info --",
                style: TextStyles.clashMedium(color: AppColors.buttonColor),
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.secondaryNameController,
                hintText: "Contact Name",
                title: "Contact Name",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.secondaryEmailController,
                hintText: "Email Address",
                title: "Email Address",
              ),
              addVertical(10),
              InputTextField(
                controller: viewProfileVM.secondaryPhoneNoController,
                hintText: "Phone Number",
                title: "Phone Number",
              ),
              addVertical(10),
            ],
          ),
        ),
      ),
    );
  }
}
