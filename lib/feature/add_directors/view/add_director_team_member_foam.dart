import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/address_auto_fill_widget.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as picker;

// ignore: must_be_immutable
class AddDirectorTeamMemberFoam extends StatefulWidget
    with BaseContextHelpers, ValidationMixins {
  final String? hinttext;
  dynamic fileName;
  AddDirectorTeamMemberFoam({super.key, this.hinttext, this.fileName});

  @override
  State<AddDirectorTeamMemberFoam> createState() =>
      _AddDirectorTeamMemberFoamState();
}

class _AddDirectorTeamMemberFoamState extends State<AddDirectorTeamMemberFoam>
    with BaseContextHelpers, ValidationMixins {
  @override
  Widget build(BuildContext context) {
    final AddDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final editVM = Provider.of<EditDeleteDirectorViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sectionHeader(editVM.isEditOurTeam
                ? 'Update Team Member'
                : "Add Team Member"),
            InkWell(
                onTap: () => navigationService.goBack(),
                child: Icon(Icons.close, color: AppColors.black))
          ],
        ),
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
            maxLength: 10,
            keyboardType: TextInputType.number,
            validator: validatePhoneNumber),
        addVertical(12),
        InputTextField(
          hintText: "Enter  Email ID ",
          title: "Email ID",
          controller: AddDirectorVM.teamEmailIDCntr,
          isRequired: true,
          validator: validateEmail,
        ),
        addVertical(12),
        ImagePickerInputField(
          title: 'User picture ',
          isRequired: true,
          imageFile: AddDirectorVM.teamMemberFile,
          onTap: () {
            imagePickerSelection(
            context,
            () => AddDirectorVM.pickUserImage(picker.ImageSource.gallery),
            () => AddDirectorVM.pickUserImage(picker.ImageSource.camera),
          );
          setState(() {
            widget.fileName = null;
          });
          },
          hintText: widget.hinttext ?? 'JPEG, PNG, PDF formats, up to 5 MB',
        ),
        if (AddDirectorVM.teamMemberFile != null) ...[
          addVertical(10),
          Align(
            alignment: Alignment.centerLeft,
            child: Stack(children: [
              Image.file(AddDirectorVM.teamMemberFile!, width: 90, height: 70),
              Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          AddDirectorVM.teamMemberFile = null;
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: Icon(Icons.close,
                              color: Colors.white, size: 16))))
            ]),
          )
        ],
        if (widget.fileName != null) ...[
          addVertical(10),
          Align(
            alignment: Alignment.centerLeft,
            child: Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImageWidget(
                      imageUrl: widget.fileName['url'] ?? '',
                      width: 90,
                      height: 70)),
              Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.fileName = null;
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close,
                              color: Colors.white, size: 16))))
            ]),
          )
        ],
        addVertical(12),
        /*InputTextField(
          hintText: "Enter  location",
          title: "Location",
          controller: AddDirectorVM.teamLocationCntr,
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter your location '
              : null,
        ),*/
        AddressAutoFillWidget(
              controller: AddDirectorVM.teamLocationCntr,
              focusNode: AddDirectorVM.locationFocusNode,
              itemClick: (val) async =>
                  await AddDirectorVM.getPlaceDetails(val.placeId ?? '')),
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
