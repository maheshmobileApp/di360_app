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
import 'package:di360_flutter/utils/email_phone_visiable_enums.dart';
import 'package:di360_flutter/widgets/country_code_number_feild.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:di360_flutter/widgets/privacy_visiablity_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

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
              controller: professDirectorVM.designationCntr),
          addVertical(20),
          InputTextField(
            title: "Name",
            hintText: 'Enter name',
            controller: professDirectorVM.nameController,
            isRequired: true,
            validator: validateFirstName,
          ),
          addVertical(20),
          InputTextField(
            title: "Email ID",
            validator: validateEmail,
            isRequired: true,
            hintText: 'Enter emailId',
            controller: professDirectorVM.emailController,
            suffixIcon: InkWell(
                onTap: () async {
                  await showDialog<String>(
                      context: context,
                      builder: (context) => EmailVisibilityDialog(
                          title: 'Email Visibility',
                          selectedOption: professDirectorVM.emailVisibility,
                          onSave: (displayName, enumValue) {
                            professDirectorVM.setEmailVisibility(displayName);
                            print(
                                'Email visibility: ${VisibilityType.fromDisplayName(displayName)?.name} ($displayName)');
                          }));
                },
                child: Icon(Icons.lock)),
          ),
          addVertical(20),
          CountryCodeNumberFeild(
            value: professDirectorVM.countryCode,
            onChanged: (v) => professDirectorVM.setCountry(v!),
            textController: professDirectorVM.mobileNumberCntr,
            suffixIcon: InkWell(
                onTap: () async {
                  await showDialog<String>(
                      context: context,
                      builder: (context) => EmailVisibilityDialog(
                          title: 'Phone Visibility',
                          selectedOption: professDirectorVM.phoneVisibility,
                          onSave: (displayName, enumValue) {
                            professDirectorVM.setPhoneVisibility(displayName);
                          }));
                },
                child: Icon(Icons.lock)),
            textFeildChanged: (value) => professDirectorVM.setNumber(value),
          ),
          addVertical(20),
          InputTextField(
            hintText: "Enter Alternate Phone Number",
            title: " Alternate Phone Number ",
            keyboardType: TextInputType.number,
            maxLength: 9,
            validator: validateOptionalPhoneNumber,
            controller: professDirectorVM.alternateNumberController,
          ),
          addVertical(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Address',
                      style: TextStyles.regular3(color: AppColors.black)),
                  Text(' *',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              GooglePlaceAutoCompleteTextField(
                textEditingController: professDirectorVM.addressController,
                googleAPIKey: "AIzaSyCN0aBdq3Yw6y7w7aBRb3uzLLGx3Zk7G70",
                inputDecoration: InputDecoration(
                  hintText: "Search Address",
                  hintStyle: TextStyles.regular4(color: AppColors.dropDownHint),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
                debounceTime: 800,
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: (Prediction prediction) {
                  professDirectorVM.latitude = prediction.lat != null
                      ? double.parse(prediction.lat!)
                      : null;
                  professDirectorVM.longitude = prediction.lng != null
                      ? double.parse(prediction.lng!)
                      : null;
                },
                itemClick: (Prediction prediction) {
                  professDirectorVM.addressController.text =
                      prediction.description ?? '';
                },
                itemBuilder: (context, index, Prediction prediction) {
                  return Container(
                    color: AppColors.whiteColor,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 7),
                        Expanded(child: Text(prediction.description ?? ""))
                      ],
                    ),
                  );
                },
                isCrossBtnShown: true,
                containerHorizontalPadding: 10,
              ),
            ],
          ),
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
          InputTextField(
              title: '',
              hintText: 'Add hobby',
              controller: professDirectorVM.hobbiesCntr,
              onSubmitted: (val) {
                professDirectorVM.addHobby(val ?? '');
              }),
          if (professDirectorVM.getHobbies.isNotEmpty) ...[
            addVertical(10),
            Consumer<AddDirectoryViewModel>(
                builder: (context, addDirectorV, child) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    List.generate(professDirectorVM.getHobbies.length, (index) {
                  final hobby = professDirectorVM.getHobbies[index];
                  return Chip(
                    label: Text(hobby),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () {
                      professDirectorVM.removeHobby(index);
                    },
                  );
                }),
              );
            }),
          ],
          addVertical(15),
          sectionHeader('Universities'),
          InputTextField(
              title: '',
              hintText: 'Add universities',
              controller: professDirectorVM.universitiesCntr,
              onSubmitted: (val) {
                professDirectorVM.addUniversities(val ?? '');
              }),
          if (professDirectorVM.getUniversitys.isNotEmpty) ...[
            addVertical(10),
            Consumer<AddDirectoryViewModel>(
                builder: (context, addDirectorV, child) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(professDirectorVM.getUniversitys.length,
                    (index) {
                  final university = professDirectorVM.getUniversitys[index];
                  return Chip(
                    label: Text(university),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () {
                      professDirectorVM.removeUniversities(index);
                    },
                  );
                }),
              );
            }),
          ],
          addVertical(20),
          InputTextField(
            hintText: "Enter your text here",
            maxLength: 500,
            isRequired: true,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter description'
                : null,
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
      title: "Profession Type",
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
      isRequired: true,
      validator: (value) => addDirectorVM.selectedBusineestype == null
          ? 'Please select category'
          : null,
    );
  }
}
