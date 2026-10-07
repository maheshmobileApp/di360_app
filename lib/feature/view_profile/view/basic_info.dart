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
import 'package:flutter/services.dart';
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
              title: "Logo",
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
                controller: viewProfileVM.abnNumberController,
                hintText: "ABN / ACN Number",
                isRequired: true,
                maxLength: 11,
                title: "ABN / ACN Number",
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
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
              hintText: "4XXXXXXXX",
              keyboardType: TextInputType.phone,
              maxLength: 9,
              readOnly: false,
              canRequestFocus: true,
              controller: viewProfileVM.phoneNoController,
              validator: validateAustralianMobileNumber,
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
                keyboardType: TextInputType.emailAddress,
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
    final items = <DropdownMenuItem<DirectoryCategories>>[];

    for (final bt in viewVM.directoryBusinessTypes) {
      // Business Type Header
      items.add(
        DropdownMenuItem<DirectoryCategories>(
          enabled: false,
          value: null,
          child: Text(
            bt.name ?? '',
            style: TextStyles.medium3(
              color: AppColors.black,
            ),
          ),
        ),
      );

      // Business Type Categories
      for (final cat in bt.directoryCategories ?? []) {
        items.add(
          DropdownMenuItem<DirectoryCategories>(
            value: cat,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                cat.name ?? '',
                style: TextStyles.regular3(
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
        );
      }
    }

    // ------------------------------------------------------------
    // Make sure selected value belongs to the current dropdown list
    // ------------------------------------------------------------

    DirectoryCategories? selectedValue;

    final currentSelected = viewVM.selectedBusineestype;

    if (currentSelected != null) {
      final matchingItems = items
          .where(
            (item) =>
                item.value != null && item.value!.id == currentSelected.id,
          )
          .toList();

      if (matchingItems.length == 1) {
        selectedValue = matchingItems.first.value;
      }
    }

    return CustomDropDown<DirectoryCategories>(
      value: selectedValue,
      title: "Business Type",
      isRequired: true,
      onChanged: (value) {
        if (value != null) {
          viewVM.setSelectedBusineestype(value);
        }
      },
      items: items,
      hintText: "Select Type",
      validator: (value) {
        if (value == null) {
          return 'Please select type';
        }

        return null;
      },
    );
  }
}
