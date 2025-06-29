import 'package:di360_flutter/widgets/closed_button_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';

class ApplyJobsForm extends StatefulWidget {
  const ApplyJobsForm({super.key});

  @override
  State<ApplyJobsForm> createState() => _ApplyJobsFormState();
}

class _ApplyJobsFormState extends State<ApplyJobsForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
   final FocusNode _firstNameFocus = FocusNode();
   final FocusNode _lastNameFocus = FocusNode();
   final FocusNode _emailFocus = FocusNode();
   final FocusNode _phoneFocus = FocusNode();

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CloseButtonWidget(
            onTap: () => Navigator.pop(context),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Apply",
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
          keyboardType: TextInputType.text,
          focusNode: _firstNameFocus,
        ),
        SizedBox(height: 16),
        InputTextField(
          title: "Last Name",
          keyboardType: TextInputType.text,
          focusNode: _lastNameFocus,
        ),
         SizedBox(height: 16),
        InputTextField(
          title: "Email ID",
          isRequired: true,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          focusNode: _emailFocus,
        ),
         SizedBox(height: 16),
        InputTextField(
          title: "Phone Number (Optional)",
          keyboardType: TextInputType.phone,
          focusNode: _phoneFocus,
        ),
      ],
    );
  }
}
