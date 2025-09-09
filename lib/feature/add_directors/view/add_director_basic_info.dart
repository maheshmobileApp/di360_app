import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddDirectorBasicInfo extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  AddDirectorBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final AddDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Basic Info"),
          addVertical(20),
          _buildBusineestype(AddDirectorVM),
          addVertical(20),
          InputTextField(
            hintText: "Enter Company Name",
            title: "Company Name",
            isRequired: true,
            controller: AddDirectorVM.CompanyNameController,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter company name'
                : null,
          ),
          addVertical(20),
          InputTextField(
            title: "Name",
            hintText: 'Enter name',
            controller: AddDirectorVM.nameController,
            validator: validateFirstName,
          ),
          addVertical(20),
          InputTextField(
            title: "Email ID",
            validator: validateEmail,
            hintText: 'Enter emailId',
            controller: AddDirectorVM.emailController,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter ABN/ACN Number ",
            title: " ABN/ACN Number ",
            isRequired: true,
            controller: AddDirectorVM.ABNNumberController,
            keyboardType: TextInputType.number,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter  ABN/ACN Number'
                : null,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter Phone Number",
            title: " Phone Number ",
            controller: AddDirectorVM.MobileNumberController,
            isRequired: true,
            keyboardType: TextInputType.number,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter Phone Number'
                : null,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter Alternate Phone Number",
            title: " Alternate Phone Number ",
            keyboardType: TextInputType.number,
            controller: AddDirectorVM.alternateNumberController,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter Address",
            title: " Address ",
            controller: AddDirectorVM.AdreessController,
            isRequired: true,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter  address' : null,
          ),
          Divider(thickness: 4),
          addVertical(20),
          _sectionHeader("Logo & Banner"),
          addVertical(20),
          LogoContainer(
            title: "Logo",
            imageFile: AddDirectorVM.logoFile,
            serverImg: AddDirectorVM.getBasicInfoData.isNotEmpty
                ? AddDirectorVM.getBasicInfoData.first.logo?.url ?? ''
                : '',
            onTap: () => _imagePickerSelection(
              context,
              () => AddDirectorVM.pickLogoImage(ImageSource.gallery),
              () => AddDirectorVM.pickLogoImage(ImageSource.camera),
            ),
          ),
          addVertical(20),
          LogoContainer(
            title: "Banner",
            imageFile: AddDirectorVM.bannerFile,
            serverImg: AddDirectorVM.getBasicInfoData.isNotEmpty
                ? AddDirectorVM.getBasicInfoData.first.bannerImage?.url ?? ''
                : '',
            onTap: () => _imagePickerSelection(
              context,
              () => AddDirectorVM.pickBannerImage(ImageSource.gallery),
              () => AddDirectorVM.pickBannerImage(ImageSource.camera),
            ),
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter your text here",
            maxLength: 500,
            maxLines: 5,
            title: "Description",
            controller: AddDirectorVM.descController,
          ),
        ],
      ),
    ));
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  void _imagePickerSelection(
    BuildContext context,
    VoidCallback? galleryOnTap,
    VoidCallback? cameraOnTap,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: galleryOnTap,
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: cameraOnTap,
            ),
          ],
        );
      },
    );
  }

  Widget _buildBusineestype(AddDirectorViewModel AddDirectorVM) {
    final allCategories = AddDirectorVM.directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toList();

    return CustomDropDown(
      value: AddDirectorVM.selectedBusineestype,
      title: "Business Type",
      onChanged: (v) =>
          AddDirectorVM.setSelectedBusineestype(v as DirectoryCategories),
      items: allCategories.map((cat) {
        return DropdownMenuItem<Object>(
          value: cat,
          child: Text(cat.name ?? "",
              style: TextStyles.medium3(color: AppColors.black)),
        );
      }).toList(),
      hintText: "Select category",
    );
  }
}
