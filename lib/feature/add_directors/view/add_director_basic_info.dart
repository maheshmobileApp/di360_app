import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddDirectorBasicInfo extends StatelessWidget with BaseContextHelpers {
  AddDirectorBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final AddDirectorVM = Provider.of<AddDirectorViewModel>(context);
    final homeViewModel = Provider.of<HomeViewModel>(context);
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
           controller:AddDirectorVM.CompanyNameController,
           validator: (value) => value == null || value.isEmpty
                ? 'Please enter company name'
                : null,
          ),
          addVertical(20),
          InputTextField(
            title: "Name",
            initialValue: homeViewModel.userName ?? '',
          ),
          addVertical(20),
          InputTextField(
            title: "Email ID",
            initialValue: homeViewModel.userID?? '',
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
    return CustomDropDown(
      value: AddDirectorVM.selectedBusineestype,
      title: "Business Type",
      onChanged: (v) => AddDirectorVM.setSelectedBusineestype(v as String),
      items: AddDirectorVM.BusineestypeList.map((value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select business type ",
    );
  }
}
