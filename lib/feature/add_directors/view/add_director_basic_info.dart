import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
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
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
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
            validator: validateFirstName,
          ),
          addVertical(20),
          InputTextField(
            title: "Email ID",
            validator: validateEmail,
            hintText: 'Enter emailId',
            controller: addDirectorVM.emailController,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter ABN/ACN Number ",
            title: " ABN/ACN Number ",
            isRequired: true,
            controller: addDirectorVM.ABNNumberController,
            keyboardType: TextInputType.number,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter  ABN/ACN Number'
                : null,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter Phone Number",
            title: " Phone Number ",
            controller: addDirectorVM.MobileNumberController,
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
            controller: addDirectorVM.alternateNumberController,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter Address",
            title: " Address ",
            controller: addDirectorVM.AdreessController,
            isRequired: true,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter  address' : null,
          ),
          Divider(thickness: 4),
          addVertical(20),
          sectionHeader("Logo & Banner"),
          addVertical(20),
          LogoContainer(
            title: "Logo",
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
            title: "Description",
            controller: addDirectorVM.descController,
          ),
        ],
      ),
    ));
  }

  Widget _buildBusineestype(AddDirectorViewModel addDirectorVM) {
    final allCategories = addDirectorVM.directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toList();

    return CustomDropDown(
      value: addDirectorVM.selectedBusineestype,
      title: "Business Type",
      onChanged: (v) =>
          addDirectorVM.setSelectedBusineestype(v as DirectoryCategories),
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
