import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationUserForm {
  static void show(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // 👈 form key

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final courseVM = Provider.of<CourseListingViewModel>(context);

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  // 👈 wrap in Form
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        "Registration",
                        style:
                            TextStyles.medium4(color: AppColors.primaryColor),
                      ),
                      Text(
                        "Course name",
                        style:
                            TextStyles.medium1(color: AppColors.lightGeryColor),
                      ),
                      const SizedBox(height: 16),

                      InputTextField(
                        controller: courseVM.userFirstNameController,
                        hintText: "Enter First Name",
                        title: "First Name",
                        isRequired: true,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter First Name'
                            : null,
                      ),
                      const SizedBox(height: 8),

                      InputTextField(
                        controller: courseVM.userLastNameController,
                        hintText: "Enter Last Name",
                        title: "Last Name",
                        isRequired: true,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter Last Name'
                            : null,
                      ),
                      const SizedBox(height: 8),

                      InputTextField(
                        controller: courseVM.userPhoneNumberController,
                        hintText: "Enter Phone Number",
                        title: "Phone Number",
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        isRequired: true,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter Phone Number'
                            : null,
                      ),
                      const SizedBox(height: 8),

                      InputTextField(
                        controller: courseVM.userEmailController,
                        hintText: "Enter Email Id",
                        title: "Email Id",
                        isRequired: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }

                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),

                      InputTextField(
                        hintText: "Give us more details",
                        maxLength: 500,
                        maxLines: 5,
                        title: "Description",
                        controller: courseVM.userDescriptionController,
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: CustomRoundedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              await courseVM.userRegisterToCourse(context);
                              navigationService.goBack();
                            }
                          },
                          backgroundColor: AppColors.primaryColor,
                          text: "Submit Details",
                          width: 150,
                          height: 42,
                          textColor: AppColors.whiteColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
