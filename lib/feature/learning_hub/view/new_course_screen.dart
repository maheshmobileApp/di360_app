import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/job_create/view/steps_view.dart';
import 'package:di360_flutter/feature/learning_hub/view/add_course.dart';
import 'package:di360_flutter/feature/learning_hub/view/contacts.dart';
import 'package:di360_flutter/feature/learning_hub/view/course_info.dart';
import 'package:di360_flutter/feature/learning_hub/view/terms_and_conditions.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/utils/create_course_enum.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
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
    final newCourseVM = context.watch<NewCourseViewModel>();
    final courseListVM = context.watch<CourseListingViewModel>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarTitleBackIconWidget(title: 'Create New Course'),
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
          _bottomButtons(context, newCourseVM, courseListVM),
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

  Widget _bottomButtons(BuildContext context, NewCourseViewModel newCourseVM,
      CourseListingViewModel courseListVM) {
    int currentStep = newCourseVM.currentStep;
    bool isLastStep = currentStep == newCourseVM.totalSteps - 1;
    bool isFirstStep = currentStep == 0;
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              width: 160,
              onPressed: () async {
                Loaders.circularShowLoader(context);
                if (newCourseVM.selectedPresentedImg?.path.isNotEmpty ??
                    false) {
                  await newCourseVM.validatePresenterImg();
                }

                if ((newCourseVM.selectedCourseHeaderBanner?.path.isNotEmpty ??
                        false) ||
                    (newCourseVM.serverCourseHeaderBanner?.url.isNotEmpty ??
                        false)) {
                  await newCourseVM.validateCourseHeaderBanner();
                }
                if ((newCourseVM.selectedGallery?.isNotEmpty ?? false) ||
                    (newCourseVM.serverGallery?.isNotEmpty ?? false)) {
                  await newCourseVM.validateGallery();
                }

                if ((newCourseVM.selectedCourseBannerImg?.isNotEmpty ??
                        false) ||
                    (newCourseVM.serverCourseBannerImg?.isNotEmpty ?? false)) {
                  await newCourseVM.validateCourseBanner();
                }
                await newCourseVM.buildCourseInfoList();
                
                if ((newCourseVM.selectedsponsoredByImg?.isNotEmpty ?? false) ||
                    (newCourseVM.serverSponsoredByImg?.isNotEmpty ?? false)) {
                  await newCourseVM.validateSponsoredByImg();
                }
                Loaders.circularHideLoader(context);

                (courseListVM.editOptionEnable)
                    ? 
                    await newCourseVM.updateCourseListing(
                        context, courseListVM.courseId, true)
                    : await newCourseVM.createdCourseListing(context, true);
                courseListVM.selectedStatus = "All";
                await courseListVM.getCoursesListingData(context);
              },
              
              backgroundColor: AppColors.timeBgColor,
              textColor: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: CustomRoundedButton(
              text: isLastStep
                  ? (courseListVM.editOptionEnable ? 'Update' : 'Submit')
                  : 'Next',
              height: 42,
              fontSize: 12,
              onPressed: () async {
                if (courseListVM.editOptionEnable) {
                  final currentFormKey =
                      newCourseVM.formKeys[newCourseVM.currentStep];
                  if (currentFormKey.currentState?.validate() ?? false) {
                    if (isLastStep) {
                      await newCourseVM.updateCourseListing(
                          context, courseListVM.courseId, false);
                      courseListVM.selectedStatus = "All";
                      await courseListVM.getCoursesListingData(context);
                    } else {
                      context.read<NewCourseViewModel>().goToNextStep();
                    }
                  }
                } else {
                  final currentFormKey =
                      newCourseVM.formKeys[newCourseVM.currentStep];
                  if (currentFormKey.currentState?.validate() ?? false) {
                    if (isLastStep) {
                      await newCourseVM.createdCourseListing(context, false);
                      courseListVM.selectedStatus = "All";
                      await courseListVM.getCoursesListingData(context);
                    } else {
                      context.read<NewCourseViewModel>().goToNextStep();
                    }
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
