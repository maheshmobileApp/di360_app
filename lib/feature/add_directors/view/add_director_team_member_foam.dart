import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as picker;

class AddDirectorTeamMemberFoam extends StatelessWidget
    with BaseContextHelpers {
  final String? hinttext;
  AddDirectorTeamMemberFoam({super.key, this.hinttext});

  @override
  Widget build(BuildContext context) {
    final AddDirectorVM = Provider.of<AddDirectorViewModel>(context);
    final editVM = Provider.of<EditDeleteDirectorViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        sectionHeader(
            editVM.isEditOurTeam ? 'Update Team Member' : "Add Team Member"),
        addVertical(6),
        InputTextField(
          hintText: "Enter Name",
          title: " Name",
          controller: AddDirectorVM.teamNameCntr,
          isRequired: true,
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter your name' : null,
        ),
        addVertical(12),
        InputTextField(
          hintText: "Enter  Designation",
          title: "Designation",
          controller: AddDirectorVM.teamDesignationCntr,
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter your designation'
              : null,
        ),
        addVertical(12),
        InputTextField(
          hintText: "Enter Phone Number",
          title: " Phone Number ",
          controller: AddDirectorVM.teamNumberCntr,
          isRequired: true,
          keyboardType: TextInputType.number,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter Phone Number'
              : null,
        ),
        addVertical(12),
        InputTextField(
          hintText: "Enter  Email ID ",
          title: "Email ID",
          controller: AddDirectorVM.teamEmailIDCntr,
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter your email id '
              : null,
        ),
        addVertical(12),
        ImagePickerInputField(
          title: 'User picture ',
          isRequired: true,
          imageFile: AddDirectorVM.teamMemberFile,
          onTap: () => imagePickerSelection(
            context,
            () => AddDirectorVM.pickUserImage(picker.ImageSource.gallery),
            () => AddDirectorVM.pickUserImage(picker.ImageSource.camera),
          ),
          hintText: hinttext ?? 'JPEG, PNG, PDF formats, up to 5 MB',
        ),
        addVertical(12),
        InputTextField(
          hintText: "Enter  location",
          title: "Location",
          controller: AddDirectorVM.teamLocationCntr,
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter your location '
              : null,
        ),
        addVertical(12),
        Text("Show in Appointments", style: TextStyles.regular2()),
        addVertical(6),
        Row(
          children: [
            _radioButton("Yes", true, AddDirectorVM.appointmentShowVal,
                (_) => AddDirectorVM.toggleAppointments(true)),
            _radioButton("No", false, AddDirectorVM.appointmentShowVal,
                (_) => AddDirectorVM.toggleAppointments(false)),
          ],
        ),
        Text("Show in our team", style: TextStyles.regular2()),
        addVertical(6),
        Row(
          children: [
            _radioButton("Yes", true, AddDirectorVM.ourTeamShowVal,
                (_) => AddDirectorVM.toggleOurTeam(true)),
            _radioButton("No", false, AddDirectorVM.ourTeamShowVal,
                (_) => AddDirectorVM.toggleOurTeam(false)),
          ],
        ),
      ]),
    );
  }

  Widget _radioButton(String label, bool value, bool groupValue,
      ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<bool>(
          visualDensity: VisualDensity.compact,
          value: value,
          groupValue: groupValue,
          activeColor: AppColors.buttonColor,
          onChanged: onChanged,
        ),
        Text(label, style: TextStyles.regular2()),
        const SizedBox(width: 20),
      ],
    );
  }
}
