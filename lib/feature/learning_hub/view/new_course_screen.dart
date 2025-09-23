import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/job_create/view/steps_view.dart';
import 'package:di360_flutter/feature/learning_hub/view/add_course.dart';
import 'package:di360_flutter/feature/learning_hub/view/contacts.dart';
import 'package:di360_flutter/feature/learning_hub/view/course_info.dart';
import 'package:di360_flutter/feature/learning_hub/view/terms_and_conditions.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/create_course_enum.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCourseScreen extends StatefulWidget {
  NewCourseScreen({super.key});

  @override
  State<NewCourseScreen> createState() => _JobCreateViewState();
}

class _JobCreateViewState extends State<NewCourseScreen> {
  @override
  Widget build(BuildContext context) {
    final newCourseVM = Provider.of<NewCourseViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              NavigationService().goBack();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Create New Course",
          style: TextStyles.medium3(),
        ),
        /*actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 241, 229, 1),
                borderRadius: BorderRadius.circular(200),
              ),
              child: Text(
                "Preview",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.0,
                  letterSpacing: 0,
                  color: Color.fromRGBO(255, 112, 0, 1),
                ),
              ),
            ),
          )
        ],*/
      ),
      body: Column(
        children: [
          _buildStepProgressBar(
              newCourseVM.currentStep, newCourseVM.totalSteps, newCourseVM),
          Expanded(
            child: PageView(
              controller: newCourseVM.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                newCourseVM.totalSteps,
                (index) => _buildStep(CourseCreateSteps.values[index],
                    newCourseVM.formKeys[index]),
              ),
            ),
          ),
          _bottomButtons(context, newCourseVM),
        ],
      ),
    );
  }

  Widget _buildStepProgressBar(
      currentStep, totalSteps, NewCourseViewModel newCourseVM) {
    return StepsView(
        currentStep: newCourseVM.currentStep,
        totalSteps: newCourseVM.totalSteps,
        stepTitles: newCourseVM.steps);
  }

  Widget _buildStep(CourseCreateSteps stepIndex, GlobalKey<FormState> key) {
    return Form(
      key: key,
      child: _getStepWidget(stepIndex),
    );
  }

  Widget _getStepWidget(CourseCreateSteps stepIndex) {
    switch (stepIndex) {
      case CourseCreateSteps.ADDCOURSE:
        return AddCourse();
      case CourseCreateSteps.COURSEINFO:
        return CourseInfo();
      case CourseCreateSteps.TERMSANDCONDITIONS:
        return TermsAndConditions();
      case CourseCreateSteps.CONTACTS:
        return Contacts();

      default:
        return Center(child: Text("Step \${stepIndex.value + 1}"));
    }
  }

  Widget _bottomButtons(BuildContext context, NewCourseViewModel newCourseVM) {
    int currentStep = newCourseVM.currentStep;
    bool isLastStep = currentStep == newCourseVM.totalSteps - 1;
    bool isFirstStep = currentStep == 0;
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5.0,
          )
        ],
      ),
      child: Row(
        children: [
          /// Previous Button
          if (!isFirstStep)
            Expanded(
              child: CustomRoundedButton(
                fontSize: 12,
                text: 'Previous',
                height: 42,
                onPressed: () {
                  newCourseVM.goToPreviousStep();
                },
                backgroundColor: AppColors.geryColor,
                textColor: Colors.black,
              ),
            ),
          if (!isFirstStep) const SizedBox(width: 16),

          /// Save Draft Button
          Expanded(
            child: CustomRoundedButton(
              fontSize: 12,
              text: 'Save Draft',
              height: 42,
              onPressed: () async {
                newCourseVM.validatePresenterImg();
                newCourseVM.validateCourseHeaderBanner();
                newCourseVM.validateGallery();
                newCourseVM.validateCourseBanner();
                final currentFormKey =
                    newCourseVM.formKeys[newCourseVM.currentStep];
                if (currentFormKey.currentState?.validate() ?? false) {
                  await newCourseVM.createdCourseListing(context, true);
                  navigationService.goBack();
                }
              },
              backgroundColor: AppColors.timeBgColor,
              textColor: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: 16),

          Expanded(
            child: CustomRoundedButton(
              text: isLastStep ? 'Submit' : 'Next',
              height: 42,
              fontSize: 12,
              onPressed: () async {
                final currentFormKey =
                    newCourseVM.formKeys[newCourseVM.currentStep];
                if (currentFormKey.currentState?.validate() ?? false) {
                  if (isLastStep) {
                    await newCourseVM.createdCourseListing(context, false);
                    navigationService.goBack();
                  } else {
                    newCourseVM.goToNextStep();
                  }
                }
              },
              backgroundColor: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
