import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BasicInfo extends StatelessWidget with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final viewProfileVM = context.read<ViewProfileViewModel>();

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LogoContainer(
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
                title: "Business Name"),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.nameController,
                hintText: "Name",
                isRequired: true,
                title: "Contact Name"),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.abnNUmberController,
                hintText: "ABN / ACN Number",
                isRequired: true,
                title: "ABN / ACN Number"),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.emailController,
                hintText: "Email",
                readOnly: true,
                title: "Email"),
            addVertical(10),
            _buildBusineestype(viewProfileVM),
            addVertical(10),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 125,
                    child: CustomDropDown(
                      value: viewProfileVM.countryCode,
                      title: "Phone Number",
                      onChanged: (v) => viewProfileVM.setCountry(v!),
                      items: [
                        DropdownMenuItem(value: '+61', child: Text('AU (+61)')),
                        DropdownMenuItem(value: '+64', child: Text('NZ (+64)')),
                      ],
                      hintText: "Select category",
                      isRequired: true,
                    ),
                  ),
                  addHorizontal(5),
                  Expanded(
                    child: TextField(
                      controller: viewProfileVM.phoneNoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(9),
                      ],
                      decoration: InputDecoration(
                          hintText: 'Enter phone number',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 12, 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: AppColors.HINT_COLOR,
                            ),
                          )),
                      onChanged: (value) {
                        viewProfileVM.setNumber(value);
                      },
                    ),
                  )
                ])
          ],
        ));
  }

  Widget _buildBusineestype(ViewProfileViewModel viewVM) {
    final allCategories = viewVM.directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toList();

    return CustomDropDown(
      value: viewVM.selectedBusineestype,
      title: "Profession Type",
      onChanged: (v) =>
          viewVM.setSelectedBusineestype(v as DirectoryCategories),
      items: allCategories.map((cat) {
        return DropdownMenuItem<Object>(
          value: cat,
          child: Text(cat.name ?? "",
              style: TextStyles.medium3(color: AppColors.black)),
        );
      }).toList(),
      hintText: "Select category",
      isRequired: true,
    );
  }
}
