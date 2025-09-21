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
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfessBasicInfo extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  const ProfessBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final professDirectorVM = Provider.of<ProfessionalAddDirectorVm>(context);
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
            hintText: "Enter designation",
            title: "Designation",
            isRequired: true,
            controller: professDirectorVM.designationCntr,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter company name'
                : null,
          ),
          addVertical(20),
          InputTextField(
            title: "Name",
            hintText: 'Enter name',
            controller: professDirectorVM.nameController,
            validator: validateFirstName,
          ),
          addVertical(20),
          InputTextField(
            title: "Email ID",
            validator: validateEmail,
            hintText: 'Enter emailId',
            controller: professDirectorVM.emailController,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter Phone Number",
            title: " Phone Number ",
            controller: professDirectorVM.mobileNumberCntr,
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
            controller: professDirectorVM.alternateNumberController,
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter Address",
            title: " Address ",
            controller: professDirectorVM.addressController,
            isRequired: true,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter  address' : null,
          ),
          Divider(thickness: 4),
          addVertical(20),
          sectionHeader("Logo & Banner"),
          addVertical(20),
          LogoContainer(
            title: "Profile image",
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
          addVertical(10),
          sectionHeader('Hobbies'),
          addVertical(20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: addDirectorVM.getBasicInfoData.first.hobbies?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                          hintText: "Enter hobbies",
                          title: "Hobbies",
                          controller: professDirectorVM.hobbiesCntr[index],
                          onChange: (value) => professDirectorVM.updateHobby(
                              context, index, value)),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: AppColors.redColor),
                      onPressed: () =>
                          professDirectorVM.removeHobby(context, index),
                    )
                  ],
                ),
              );
            },
          ),
          addVertical(10),
          ElevatedButton.icon(
            onPressed: () => professDirectorVM.addHobby(context),
            icon: const Icon(Icons.add),
            label: const Text("Add hobbies"),
          ),
          sectionHeader('Universities'),
          addVertical(20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                addDirectorVM.getBasicInfoData.first.universitySchool?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                          hintText: "Enter universities",
                          title: "Universities School",
                          controller: professDirectorVM.universitiesCntr[index],
                          onChange: (value) => professDirectorVM
                              .updateUniversities(context, index, value)),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: AppColors.redColor),
                      onPressed: () =>
                          professDirectorVM.removeUniversities(context, index),
                    )
                  ],
                ),
              );
            },
          ),
          addVertical(10),
          ElevatedButton.icon(
            onPressed: () => professDirectorVM.addUniversities(context),
            icon: const Icon(Icons.add),
            label: const Text("Add universities"),
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter your text here",
            maxLength: 500,
            maxLines: 5,
            title: "Description",
            controller: professDirectorVM.descController,
          ),
        ],
      ),
    ));
  }

  Widget _buildBusineestype(AddDirectoryViewModel addDirectorVM) {
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
