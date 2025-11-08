import 'dart:io';

import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/attachment.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:di360_flutter/widgets/resume_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplyJobsView extends StatefulWidget {
  const ApplyJobsView({super.key});

  @override
  State<ApplyJobsView> createState() => _ApplyJobsViewState();
}

class _ApplyJobsViewState extends State<ApplyJobsView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();

  File? _resumeFile;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _messageFocus.dispose();
    super.dispose();
  }

  void _onResumeSelected(File? file) {
    setState(() {
      _resumeFile = file;
    });
  }

  bool _validateForm() {
    if (_firstNameController.text.trim().isEmpty) {
      _showErrorSnackBar('First name is required');
      return false;
    }
    if (_emailController.text.trim().isEmpty) {
      _showErrorSnackBar('Email is required');
      return false;
    }
    if (_emailController.text.trim().isNotEmpty &&
        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text.trim())) {
      _showErrorSnackBar('Please enter a valid email address');
      return false;
    }
    return true;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _submitApplication() async {
    if (_validateForm()) {
      final dentalProfessionalId =
          await LocalStorage.getStringVal(LocalStorageConst.userId);

      final provider = Provider.of<JobSeekViewModel>(context, listen: false);
      final jobId = provider.selectedJob?.id ?? '';

      ApplyJobRequest payload = ApplyJobRequest(
        jobId: jobId,
        dentalProfessionalId: dentalProfessionalId,
        message: _messageController.text.trim(),
        attachments: _resumeFile != null
            ? Attachment(url: _resumeFile!.path, name: '', type: '')
            : Attachment(url: '', name: '', type: ''),
        firstName: _firstNameController.text.trim(),
      );

      Loaders.circularShowLoader(context);
      final result = await provider.applyJob(payload);
      Loaders.circularHideLoader(context);

      if (result) {
        //  fetch apply status (no await, because it's a void function)
        provider.getApplyJobStatus(jobId, dentalProfessionalId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Application submitted successfully!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit application. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(
          "Apply for Job",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: _submitApplication,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Submit",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputTextField(
              title: "First Name",
              hintText: "Enter your first name",
              isRequired: true,
              controller: _firstNameController,
              keyboardType: TextInputType.text,
              focusNode: _firstNameFocus,
            ),
            SizedBox(height: 16),
            InputTextField(
              title: "Last Name",
              hintText: "Enter your last name",
              controller: _lastNameController,
              keyboardType: TextInputType.text,
              focusNode: _lastNameFocus,
            ),
            SizedBox(height: 16),
            InputTextField(
              title: "Email ID",
              hintText: "Enter your email address",
              isRequired: true,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: _emailFocus,
            ),
            SizedBox(height: 16),
            InputTextField(
              title: "Phone Number (Optional)",
              hintText: "Enter your phone number",
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              focusNode: _phoneFocus,
            ),
            SizedBox(height: 16),
            ResumeUploadWidget(
              onFileSelected: _onResumeSelected,
              isRequired: false,
            ),
            SizedBox(height: 16),
            InputTextField(
              hintText: "Enter your message here",
              maxLength: 500,
              maxLines: 5,
              title: "Message",
              controller: _messageController,
              focusNode: _messageFocus,
            ),
            SizedBox(height: 24),
          ],
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
}
