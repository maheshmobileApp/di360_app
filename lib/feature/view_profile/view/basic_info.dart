import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicInfo extends StatelessWidget with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final viewProfileVM = Provider.of<ViewProfileViewModel>(context);

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ImagePickerField(
                title: "Presented By (Image)",
                isRequired: true,
                serverImage: viewProfileVM.logoUrl,
                serverImageType: "image",
                showPreview: true),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.businessNameController,
                hintText: "Business Name",
                title: "Business Name"),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.nameController,
                hintText: "Name",
                title: "Contact Name"),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.abnNUmberController,
                hintText: "ABN / ACN Number",
                title: "ABN / ACN Number"),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.emailController,
                hintText: "Email",
                title: "Email"),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.professionTypeController,
                hintText: "Profession Type",
                title: "Profession Type"),
            addVertical(10),
            InputTextField(
                controller: viewProfileVM.phoneNoController,
                hintText: "Phone Number",
                title: "Phone Number"),
          ],
        ));
  }
}
