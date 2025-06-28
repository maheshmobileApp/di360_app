import 'package:di360_flutter/widgets/closed_button_widget.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';

class ApplyJobsForm extends StatefulWidget {
  const ApplyJobsForm({super.key});

  @override
  State<ApplyJobsForm> createState() => _ApplyJobsFormState();
}

class _ApplyJobsFormState extends State<ApplyJobsForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Apply Jobs",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  InputTextField(
                    title: "First Name",
                    isRequired: true,
                    controller: _firstNameController,
                    hintText: "Enter First Name",
                  ),
                  SizedBox(height: 16),
                  InputTextField(
                    title: "Last Name",
                    isRequired: true,
                    controller: _lastNameController,
                    hintText: "Enter Last Name",
                  ),
                  SizedBox(height: 16),
                  InputTextField(
                    title: "Email ID",
                    isRequired: true,
                    controller: _emailController,
                    hintText: "Enter Email",
                  ),
                  SizedBox(height: 16),
                  InputTextField(
                    title: "Phone Number (Optional)",
                    controller: _phoneNumberController,
                    hintText: "Enter Phone Number",
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomRoundedButton(
                      text: "Continue",
                      onPressed: () {
                        
                      },
                      backgroundColor: Colors.orange,
                      textColor: Colors.white,
                      width: 140,
                      height: 50,
                    ),
                  ),
                ],
              ),
              CloseButtonWidget(
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
