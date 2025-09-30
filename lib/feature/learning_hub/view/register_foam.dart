import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
class RegistrationUserForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegistrationUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final courseVM = Provider.of<CourseListingViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Register for ${"< Course Name >"}",
          style: TextStyles.medium4(color: AppColors.whiteColor),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputTextField(
                controller: courseVM.userFirstNameController,
                hintText: "Enter your first name",
                title: "First Name",
                isRequired: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter First Name' : null,
              ),
              const SizedBox(height: 12),

              InputTextField(
                controller: courseVM.userLastNameController,
                hintText: "Enter your last name",
                title: "Last Name",
                isRequired: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter Last Name' : null,
              ),
              const SizedBox(height: 12),

              InputTextField(
                controller: courseVM.userPhoneNumberController,
                hintText: "Enter your phone number",
                title: "Phone Number",
                keyboardType: TextInputType.number,
                maxLength: 10,
                isRequired: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter Phone Number' : null,
              ),
              const SizedBox(height: 12),

              InputTextField(
                controller: courseVM.userEmailController,
                hintText: "Enter your email address",
                title: "Email",
                isRequired: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              InputTextField(
                controller: courseVM.userDescriptionController,
                hintText: "Give us more details",
                title: "Description",
                maxLines: 5,
                maxLength: 500,
              ),
              const SizedBox(height: 20),

              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await courseVM.userRegisterToCourse(context);
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.arrow_forward, color: Colors.orange),
                  label: const Text(
                    "SUBMIT DETAILS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
