import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfessionalPersonalDetails extends StatelessWidget
    with BaseContextHelpers {
  const ProfessionalPersonalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final viewProfileVM = Provider.of<ViewProfileViewModel>(context);

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          LogoContainer(
            title: "Logo",
            imageFile: viewProfileVM.logoFile,
            serverImg: viewProfileVM.logoUrl ?? '',
            onTap: () => imagePickerSelection(
                context,
                () => viewProfileVM.pickLogoImage(ImageSource.gallery, context),
                () => viewProfileVM.pickLogoImage(ImageSource.camera, context)),
          ),
          addVertical(10),
          CustomDropDown(
              value: viewProfileVM.selectedSalutation,
              title: "Select Type",
              onChanged: (v) => viewProfileVM.selectedSalutation = v,
              items: ConstantData.salutationList
                  .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text('${e}.',
                          style: TextStyles.medium3(color: AppColors.black))))
                  .toList(),
              hintText: "Select type"),
          addVertical(10),
          InputTextField(
              controller: viewProfileVM.firstNameController,
              hintText: "First Name",
              title: "first Name"),
          addVertical(10),
          InputTextField(
              controller: viewProfileVM.middleNameController,
              hintText: "Middle Name",
              title: "Middle Name"),
          addVertical(10),
          InputTextField(
              controller: viewProfileVM.lastNameController,
              hintText: "Last Name",
              title: "Last Name"),
          addVertical(10),
          CustomDatePicker(
              controller: viewProfileVM.dateOfBirthController,
              title: "Date of Birth",
              hintText: "Select date",
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: viewProfileVM.scheduleDate ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  viewProfileVM.setScheduleDate(picked);
                }
              }),
          addVertical(10),
          CustomDropDown(
              value: viewProfileVM.selectedGender,
              title: "Gender",
              onChanged: (v) => viewProfileVM.selectedGender = v,
              items: ConstantData.genderList
                  .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e,
                          style: TextStyles.medium3(color: AppColors.black))))
                  .toList(),
              hintText: "Select gender"),
        ]));
  }
}
