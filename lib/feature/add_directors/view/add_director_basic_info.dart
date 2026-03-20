import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:di360_flutter/widgets/address_auto_fill_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:di360_flutter/widgets/phone_prefix_drodown.dart';
import 'package:di360_flutter/widgets/privacy_visiablity_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddDirectorBasicInfo extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  AddDirectorBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader("Basic Info"),
          addVertical(20),
          _buildBusineestype(addDirectorVM),
          addVertical(20),
          InputTextField(
            hintText: "Enter Company Name",
            title: "Company Name",
            isRequired: true,
            controller: addDirectorVM.CompanyNameController,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter company name'
                : null,
          ),
          addVertical(20),
          InputTextField(
            title: "Name",
            hintText: 'Enter name',
            controller: addDirectorVM.nameController,
            isRequired: true,
            validator: validateFirstName,
          ),
          addVertical(20),
          InputTextField(
            title: "Email ID",
            validator: validateEmail,
            hintText: 'Enter emailId',
            isRequired: true,
            readOnly: true,
            controller: addDirectorVM.emailController,
            suffixIcon: InkWell(
                onTap: () async {
                  await showDialog<String>(
                      context: context,
                      builder: (context) => EmailVisibilityDialog(
                          title: 'Email Visibility',
                          selectedOption: addDirectorVM.emailVisibility,
                          onSave: (displayName, enumValue) {
                            addDirectorVM.setEmailVisibility(displayName);
                          }));
                },
                child: Icon(Icons.lock)),
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter ABN/ACN Number ",
            title: " ABN/ACN Number ",
            isRequired: true,
            controller: addDirectorVM.ABNNumberController,
            keyboardType: TextInputType.number,
            validator: validateABNNumber,
            maxLength: 11,
          ),
          addVertical(20),
          InputTextField(
            title: "Phone Number",
            isRequired: true,
            hintText: "Enter phone number",
            keyboardType: TextInputType.phone,
            maxLength: 9,
            readOnly: true,
            controller: addDirectorVM.MobileNumberController,
            validator: validateContactPhoneNumber,
            prefixIcon: PhonePrefixDropdown(
              value: addDirectorVM.selectedPhoneCode ?? "",
              items: ConstantData.phoneCodeList,
              onChanged: (value) {
                addDirectorVM.setPhoneCode(value ?? "");
              },
            ),
            suffixIcon: InkWell(
                onTap: () async {
                  await showDialog<String>(
                      context: context,
                      builder: (context) => EmailVisibilityDialog(
                          title: 'Phone Visibility',
                          selectedOption: addDirectorVM.phoneVisibility,
                          onSave: (displayName, enumValue) {
                            addDirectorVM.setPhoneVisibility(displayName);
                          }));
                },
                child: Icon(Icons.lock)),
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter Business Phone Number",
            title: " Business Phone Number ",
            keyboardType: TextInputType.number,
            maxLength: 10,
            validator: validateOptionalPhoneNumber,
            controller: addDirectorVM.businessPhoneCntr,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter business email",
            title: " Business Email ",
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            controller: addDirectorVM.businessEmailCntr,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter Alternate Phone Number",
            title: " Alternate Phone Number ",
            keyboardType: TextInputType.number,
            maxLength: 9,
            validator: validateOptionalPhoneNumber,
            controller: addDirectorVM.alternateNumberController,
          ),
          addVertical(20),
          AddressAutoFillWidget(
            controller: addDirectorVM.addressController,
            focusNode: addDirectorVM.addressFocusNode,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              addDirectorVM.latitude =
                  prediction.lat != null ? double.parse(prediction.lat!) : null;
              addDirectorVM.longitude =
                  prediction.lng != null ? double.parse(prediction.lng!) : null;
            },
          ),
          addVertical(20),
          sectionHeader("Logo & Banner"),
          addVertical(20),
          LogoContainer(
            title: "Logo",
            isRequired: true,
            imageFile: addDirectorVM.logoFile,
            serverImg: addDirectorVM.getBasicInfoData.isNotEmpty
                ? addDirectorVM.getBasicInfoData.first.logo?.url ?? ''
                : '',
            onTap: () => imagePickerSelection(
              context,
              () => addDirectorVM.pickLogoImage(ImageSource.gallery),
              () => addDirectorVM.pickLogoImage(ImageSource.camera),
            ),
          ),
          addVertical(20),
          LogoContainer(
            title: "Banner",
            isRequired: true,
            imageFile: addDirectorVM.bannerFile,
            serverImg: addDirectorVM.getBasicInfoData.isNotEmpty
                ? addDirectorVM.getBasicInfoData.first.bannerImage?.url ?? ''
                : '',
            onTap: () => imagePickerSelection(
              context,
              () => addDirectorVM.pickBannerImage(ImageSource.gallery),
              () => addDirectorVM.pickBannerImage(ImageSource.camera),
            ),
          ),
          addVertical(20),
          InputTextField(
              hintText: "Enter your text here",
              maxLength: 500,
              maxLines: 5,
              isRequired: true,
              title: "Description",
              controller: addDirectorVM.descController,
              validator: validateDesc),
        ],
      ),
    ));
  }

  Widget _buildBusineestype(AddDirectoryViewModel addDirectorVM) {
    final items = <DropdownMenuItem<Object>>[];

    for (var bt in addDirectorVM.directoryBusinessTypes) {
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
      value: addDirectorVM.selectedBusineestype,
      title: "Profession Type",
      isRequired: true,
      onChanged: (v) =>
          addDirectorVM.setSelectedBusineestype(v as DirectoryCategories),
      items: items,
      hintText: "Select category",
      validator: (value) => addDirectorVM.selectedBusineestype == null
          ? 'Please select category'
          : null,
    );
  }
}
