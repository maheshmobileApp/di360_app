import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewProfileVM = Provider.of<ViewProfileViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ImagePickerField(
                title: "Presented By (Image)",
                isRequired: true,
                serverImage: viewProfileVM.logoUrl,
                serverImageType: "image",
                
                showPreview: true,
             
                
              ),
               SizedBox(height: 8,),
            InputTextField(
              controller: viewProfileVM.businessNameController,
              hintText: "Business Name",
              title: "Business Name",
            ),
            SizedBox(height: 8,),
            InputTextField(
              controller: viewProfileVM.abnNUmberController,
              hintText: "ABN / ACN Number",
              title: "ABN / ACN Number",
            ),
            
          ],
        ),
      ),
    );
  }
}
