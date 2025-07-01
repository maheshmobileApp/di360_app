import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view/job_info.dart';
import 'package:di360_flutter/feature/job_create/view/job_location_view.dart';
import 'package:di360_flutter/feature/job_create/view/logo_banner_view.dart';
import 'package:di360_flutter/feature/job_create/view/other_links_view.dart';
import 'package:di360_flutter/feature/job_create/view/steps_view.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobCreateView extends StatelessWidget with BaseContextHelpers {
  JobCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Create New Job",
          style: TextStyles.medium2(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              child: Text(
                "Preview",
                style: TextStyles.regular2(),
              ),
              decoration: BoxDecoration(color: AppColors.timeBgColor),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _buildStepProgressBar(jobCreateVM.currentStep,jobCreateVM.totalSteps, jobCreateVM),
          Expanded(
            child: PageView(
              controller:jobCreateVM.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                  jobCreateVM.totalSteps, (index) => _buildStep(index)),
            ),
          ),
          _bottomButtons(context, jobCreateVM),
        ],
      ),
    );
  }

  Widget _buildStepProgressBar(currentStep, totalSteps,JobCreateViewModel jobcreateVm) {
    return StepsView(
        currentStep: 0, totalSteps: 5, stepTitles: jobcreateVm.steps);
  }

  Widget _buildStep(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return JobInfo();
        case 1:
        return JobLocationView();
        case 2:
        return OtherLinksView();
         case 3:
         return LogoAndBannerView();

      default:
        return Center(child: Text("Step ${stepIndex + 1}"));
    }
  }

  Widget _bottomButtons(BuildContext context, JobCreateViewModel jobCreateVM) {
    bool isLastStep = jobCreateVM.currentStep == jobCreateVM.totalSteps - 1;
    bool isFirstStep = jobCreateVM.currentStep == 0;
    return Container(
      height: getSize(context).height * 0.1,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.87),
          blurRadius: 5.0,
        )
      ], color: AppColors.whiteColor),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomRoundedButton(
                height: 42,
                text: 'Save Draft',
                onPressed: () {
                  jobCreateVM.goToPreviousStep();
                },
                backgroundColor: AppColors.timeBgColor,
                textColor: AppColors.primaryColor,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomRoundedButton(
                text: isLastStep ? 'Save Job' : 'Next',
                height: 42,
                onPressed: () {
                  jobCreateVM.goToNextStep();
                },
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
