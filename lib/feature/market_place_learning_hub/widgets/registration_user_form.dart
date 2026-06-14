import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/widgets/show_update_profile_popup.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationUserForm {
  static void show(BuildContext context, String courseName, String createdById,
      String courseId, String registrationLink) {
    final formKey = GlobalKey<FormState>();
    final courseVM =
        Provider.of<MarketPlaceLearningHubViewModel>(context, listen: false);

    courseVM.getProfile().then((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Consumer<MarketPlaceLearningHubViewModel>(
            builder: (context, courseVM, _) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Submit and Register for",
                                  style: TextStyles.medium4(
                                      color: AppColors.black),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      navigationService.goBack();
                                    },
                                    child: const Icon(Icons.close,
                                        color: AppColors.black, size: 24))
                              ]),
                          Text(
                            capitalizeWords(courseName),
                            style: TextStyles.medium3(
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(height: 16),
                          InputTextField(
                            controller: courseVM.userFirstNameController,
                            hintText: "Enter First Name",
                            title: "First Name",
                            maxLength: 75,
                            isRequired: true,
                            readOnly: true,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter First Name'
                                : null,
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            controller: courseVM.userLastNameController,
                            hintText: "Enter Last Name",
                            title: "Last Name",
                            maxLength: 75,
                            isRequired: true,
                            readOnly: true,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter Last Name'
                                : null,
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            controller: courseVM.userPhoneNumberController,
                            hintText: "Enter Phone Number",
                            title: "Phone Number",
                            readOnly: true,
                            maxLength: 12,
                            keyboardType: TextInputType.number,
                            isRequired: true,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly,
                            // ],
                            // validator: courseVM.validatePhoneNumber
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                              controller: courseVM.userEmailController,
                              hintText: "Enter Email Id",
                              title: "Email Id",
                              isRequired: true,
                              readOnly: true,
                              validator: courseVM.validateEmailField),
                          const SizedBox(height: 8),
                          InputTextField(
                            hintText: "Give us more details",
                            maxLength: 1000,
                            maxLines: 5,
                            title: "Description",
                            controller: courseVM.userDescriptionController,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: CustomRoundedButton(
                              onPressed: () async {
                                final isValidPhone =
                                    courseVM.isValidAusPhoneNumber(courseVM
                                        .userPhoneNumberController.text);

                                if (!isValidPhone) {
                                  showUpdateMobileNumberDialog(context,
                                      onUpdateProfile: () {
                                    navigationService.goBack();
                                    courseVM.viewProfileNavigationHandle();
                                  });
                                  return;
                                }
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await courseVM.userRegisterToCourse(context);
                                  navigationService.goBack();
                                  courseVM.clearAll();
                                  await courseVM.registerCourseHandler(
                                      context, createdById);
                                  if (registrationLink.trim().isNotEmpty) {
                                    alertPopup(
                                      context,
                                      "You are being redirected to the registration link",
                                      onBack: () async {
                                        final raw = registrationLink.trim();
                                        if (raw.isEmpty) {
                                          navigationService.goBack();
                                          return;
                                        }
                                        final urlStr =
                                            raw.startsWith('http://') ||
                                                    raw.startsWith('https://')
                                                ? raw
                                                : 'https://$raw';
                                        final url = Uri.tryParse(urlStr);
                                        if (url != null &&
                                            await canLaunchUrl(url)) {
                                          await launchUrl(url,
                                              mode: LaunchMode
                                                  .externalApplication);
                                        } else {
                                          scaffoldMessenger(
                                              'Could not open registration link');
                                        }
                                        navigationService.goBack();
                                      },
                                    );
                                  }
                                  await courseVM.getAllLearningHubData(context);
                                  await courseVM.getCourseDetails(
                                      context, courseId);
                                }
                              },
                              backgroundColor: AppColors.primaryColor,
                              text: "Submit And Register",
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
            ),
          );
        },
      );
    });
  }

  static String capitalizeWords(String text) {
    return text
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : '',
        )
        .join(' ');
  }
}
