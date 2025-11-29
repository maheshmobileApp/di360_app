import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialMediaLinks extends StatelessWidget with BaseContextHelpers {
  SocialMediaLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<NewCourseViewModel>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader("Social Media Links"),
              SizedBox(height: 16),
              InputTextField(
                controller: jobCreateVM.youtubeController,
                hintText: "Enter Youtube link",
                title: "Youtube Link",
                maxLength: 100,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: jobCreateVM.facebookController,
                hintText: "Enter Facebook link",
                title: "Facebook Link",
                maxLength: 100,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: jobCreateVM.instagramController,
                hintText: "Enter Instagram link",
                title: "Instagram Link",
                maxLength: 100,
              ),
              SizedBox(height: 8),
              InputTextField(
                controller: jobCreateVM.linkedinController,
                hintText: "Enter Linkedin link",
                title: "Linkedin Link",
                maxLength: 100,
              ),
              SizedBox(height: 10),
              _sectionHeader("Others"),
              SizedBox(height: 16),
              _buildCommunityTypes(jobCreateVM)
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _buildCommunityTypes(NewCourseViewModel jobCreateVM) {
    final selectedValue = jobCreateVM.communityTypes.contains(jobCreateVM.selectedCommunityType) 
        ? jobCreateVM.selectedCommunityType 
        : null;
        
    return CustomDropDown(
      isRequired: true,
      value: selectedValue,
      title: "Community User Type",
      onChanged: (v) {
        jobCreateVM.setCommunityType(v as String);
      },
      items: jobCreateVM.communityTypes
          .map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Category",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select category'
          : null,
    );
  }
}
