import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/feature/view_profile/widgets/profile_image_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:di360_flutter/widgets/phone_prefix_drodown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BasicInfo extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  @override
  Widget build(BuildContext context) {
    final viewProfileVM = context.read<ViewProfileViewModel>();

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileImageWidget(
              title: "Profile Image",
              imageFile: viewProfileVM.logoFile,
              serverImg: viewProfileVM.logoUrl ?? '',
              onTap: () => imagePickerSelection(
                  context,
                  () =>
                      viewProfileVM.pickLogoImage(ImageSource.gallery, context),
                  () =>
                      viewProfileVM.pickLogoImage(ImageSource.camera, context)),
            ),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.businessNameController,
                hintText: "Business Name",
                isRequired: true,
                title: "Business Name",
                validator: validateBusinessName),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.nameController,
                hintText: "Name",
                isRequired: true,
                title: "Contact Name",
                validator: validateName),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.abnNUmberController,
                hintText: "ABN / ACN Number",
                isRequired: true,
                maxLength: 11,
                title: "ABN / ACN Number",
                validator: validateABNNumber),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.emailController,
                hintText: "Email",
                readOnly: true,
                isRequired: true,
                title: "Email",
                validator: validateEmail),
            addVertical(10),
            _buildBusineestype(viewProfileVM),
            addVertical(10),
            InputTextField(
              title: "Mobile Number",
              isRequired: true,
              hintText: "Enter Mobile Number",
              keyboardType: TextInputType.phone,
              maxLength: 9,
              readOnly: false,
              canRequestFocus: true,
              controller: viewProfileVM.phoneNoController,
              validator: validateContactPhoneNumber,
              prefixIcon: PhonePrefixDropdown(
                value: viewProfileVM.selectedPhoneCode ?? '',
                items: ConstantData.phoneCodeList,
                onChanged: (value) {
                  viewProfileVM.setPhoneCode(value ?? "");
                },
              ),
            ),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.businessPhoneNoController,
                hintText: "Enter Business Phone",
                title: "Business Phone",
                maxLength: 10,
                validator: validateBusinessPhoneNumber),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.businessEmailController,
                hintText: "Enter Business Email",
                title: "Business Email",
                validator: validateEmail),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.websiteUrlController,
                hintText: "Enter Website Link",
                title: "Website Link",
                validator: validateOptionalUrl),
          ],
        ));
  }

  Widget _buildBusineestype(ViewProfileViewModel viewVM) {
    final items = <DropdownMenuItem<Object>>[];

    for (var bt in viewVM.directoryBusinessTypes) {
      items.add(DropdownMenuItem<Object>(
        enabled: false,
        value: bt.name,
        child: Text(bt.name ?? '',
            style: TextStyles.medium3(color: AppColors.black)),
      ));
      for (var cat in bt.directoryCategories ?? []) {
        items.add(DropdownMenuItem<Object>(
          value: cat,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(cat.name ?? '',
                style: TextStyles.regular3(color: AppColors.secondaryColor)),
          ),
        ));
      }
    }

    return CustomDropDown(
      value: viewVM.selectedBusineestype,
      title: "Business Type",
      isRequired: true,
      onChanged: (v) =>
          viewVM.setSelectedBusineestype(v as DirectoryCategories),
      items: items,
      hintText: "Select category",
      validator: (value) =>
          viewVM.selectedBusineestype == null ? 'Please select category' : null,
    );
  }
}
