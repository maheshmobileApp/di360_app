import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view/steps_view.dart';
import 'package:di360_flutter/feature/job_profile/view/job_profile_availability.dart';
import 'package:di360_flutter/feature/job_profile/view/job_profile_location.dart';
import 'package:di360_flutter/feature/job_profile/view/job_profile_pers_info.dart';
import 'package:di360_flutter/feature/job_profile/view/job_profile_profe_info.dart';
import 'package:di360_flutter/feature/job_profile/view/job_profile_skills.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_create_view_model.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/job_profile_enum.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobProfileView extends StatefulWidget with BaseContextHelpers {
  JobProfileView({super.key, this.profile, required isEdit});
  final JobProfiles? profile;

  @override
  State<JobProfileView> createState() => _JobProfileViewState();
}

class _JobProfileViewState extends State<JobProfileView> {
  @override
  void initState() {
    initilizeTheProfileData();
    super.initState();
  }

  initilizeTheProfileData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final jobProfileVM =
          Provider.of<JobProfileCreateViewModel>(context, listen: false);
      await jobProfileVM.initializeTheData(
          profile: widget.profile, isEdit: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobProfileVM = Provider.of<JobProfileCreateViewModel>(context);
    final jobProfileListVM = Provider.of<JobProfileListingViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () {
              NavigationService().goBack();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Create Profile",
          style: TextStyles.medium2(),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await jobProfileVM.setJobProfilePreviewData();
              navigationService.navigateToWithParams(
            RouteList.talentdetailsScreen,
            params: jobProfileVM.jobProfilePreviewData,
          );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 241, 229, 1),
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  child: Text(
                    "Preview",
                    style: TextStyles.semiBold(
                        color: Color.fromRGBO(255, 112, 0, 1)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _buildStepProgressBar(
              jobProfileVM.currentStep, jobProfileVM.totalSteps, jobProfileVM),
          Expanded(
            child: PageView(
              controller: jobProfileVM.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                jobProfileVM.totalSteps,
                (index) => _buildStep(
                    JobProfileStep.values[index], jobProfileVM.formKeys[index]),
              ),
            ),
          ),
          _bottomButtons(context, jobProfileVM, jobProfileListVM),
        ],
      ),
    );
  }

  Widget _buildStepProgressBar(
      currentStep, totalSteps, JobProfileCreateViewModel jobProfileVM) {
    return StepsView(
        currentStep: jobProfileVM.currentStep,
        totalSteps: jobProfileVM.totalSteps,
        stepTitles: jobProfileVM.steps);
  }

  Widget _buildStep(JobProfileStep stepIndex, GlobalKey<FormState> key) {
    return Form(
      key: key,
      child: _getStepWidget(stepIndex),
    );
  }

  Widget _getStepWidget(JobProfileStep stepIndex) {
    switch (stepIndex) {
      case JobProfileStep.PERSONAL:
        return JobProfilePersInfo();
      case JobProfileStep.PROFESSIONAL:
        return JobProfileProfeInfo();
      case JobProfileStep.SKILLS:
        return JobProfileSkills();
      case JobProfileStep.AVAILABILITY:
        return JobProfileAvailability();
      case JobProfileStep.LOCATION:
        return JobProfileLocation();
      default:
        return Center(child: Text("Step ${stepIndex.value + 1}"));
    }
  }

  Widget _bottomButtons(
      BuildContext context,
      JobProfileCreateViewModel jobProfileVM,
      JobProfileListingViewModel jobProfileListVM) {
    int currentStep = jobProfileVM.currentStep;
    bool isLastStep = currentStep == jobProfileVM.totalSteps - 1;
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
                  jobProfileVM.goToPreviousStep();
                },
                backgroundColor: AppColors.geryColor,
                textColor: Colors.black,
              ),
            ),
          if (!isFirstStep) const SizedBox(width: 16),
          Expanded(
            child: CustomRoundedButton(
              fontSize: 12,
              text: 'Save Draft',
              height: 42,
              onPressed: () async {
                print("Save Draft Clicked");
                (jobProfileListVM.editProfileEnable)
                    ? await jobProfileVM.updateJobProfile(
                        context, true, jobProfileListVM.jobProfileId ?? "")
                    : await jobProfileVM.createJobProfile(context, true);
                await jobProfileListVM.fetchJobProfiles(context);
                Loaders.circularHideLoader(context);

                navigationService.goBack();
                jobProfileVM.clearAllData();
              },
              backgroundColor: AppColors.timeBgColor,
              textColor: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: 16),

          Expanded(
            child: CustomRoundedButton(
              text: isLastStep
                  ? (jobProfileListVM.editProfileEnable)
                      ? "Update"
                      : "Submit"
                  : 'Next',
              height: 42,
              fontSize: 12,
              onPressed: () async {
                final currentFormKey =
                    jobProfileVM.formKeys[jobProfileVM.currentStep];
                final isValid = currentFormKey.currentState!.validate();
                if (isValid) {
                  if (isLastStep) {
                    print("Submit Clicked");
                    (jobProfileListVM.editProfileEnable)
                        ? await jobProfileVM.updateJobProfile(
                            context, false, jobProfileListVM.jobProfileId ?? "")
                        : await jobProfileVM.createJobProfile(context, false);
                    await jobProfileListVM.fetchJobProfiles(context);
                    Loaders.circularHideLoader(context);

                    navigationService.goBack();
                    jobProfileVM.clearAllData();
                  } else {
                    jobProfileVM.goToNextStep();
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
