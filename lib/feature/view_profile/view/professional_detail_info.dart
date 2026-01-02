import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfessionalDetailInfo extends StatelessWidget with BaseContextHelpers {
  const ProfessionalDetailInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final viewProfileVM = context.read<ViewProfileViewModel>();

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBusineestype(viewProfileVM),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.aphraNumberController,
                hintText: "APHRA Registration Number",
                title: "APHRA Registration Number"),
          ],
        ));
  }

  Widget _buildBusineestype(ViewProfileViewModel viewVM) {
    final allCategories = viewVM.directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toSet()
        .toList();

    // Ensure selected value exists in the list
    final selectedValue = allCategories.contains(viewVM.selectedBusineestype) 
        ? viewVM.selectedBusineestype 
        : null;

    return CustomDropDown(
      value: selectedValue,
      title: "Profession Type",
      onChanged: (v) =>
          viewVM.setSelectedBusineestype(v as DirectoryCategories),
          isRequired: true,
          validator: (v) => v == null ? 'Select profession type' : null,
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