import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfessionalDetailInfo extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  const   ProfessionalDetailInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final viewProfileVM = context.watch<ViewProfileViewModel>();
    final excludedTypes = [
      "Dental Receptionist",
      "Dental Therapist",
      "Dental Assistant",
      "Dental Technician"
    ];
    final shouldShowAphra =
        !excludedTypes.contains(viewProfileVM.selectedBusineestype?.name);

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBusineestype(viewProfileVM),
            if (shouldShowAphra) ...[
              addVertical(10),
              InputTextField(
                  controller: viewProfileVM.aphraNumberController,
                  hintText: "AHPRA Registration Number",
                  title: "AHPRA Registration Number",
                  helperText: '3 letters and 10 digits (e.g., MED0001234567)',
                  validator: validateAphraNumber),
            ],
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
      title: "Profession Type",
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
