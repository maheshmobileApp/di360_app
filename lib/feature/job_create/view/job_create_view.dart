import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/job_create/view/job_info.dart';
import 'package:di360_flutter/feature/job_create/view/job_location_view.dart';
import 'package:di360_flutter/feature/job_create/view/logo_banner_view.dart';
import 'package:di360_flutter/feature/job_create/view/other_info_view.dart';
import 'package:di360_flutter/feature/job_create/view/other_links_view.dart';
import 'package:di360_flutter/feature/job_create/view/pay_details.dart';
import 'package:di360_flutter/feature/job_create/view/steps_view.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/job_create_enum.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobCreateView extends StatefulWidget {
  JobCreateView({super.key});
  @override
  State<JobCreateView> createState() => _JobCreateViewState();
}

class _JobCreateViewState extends State<JobCreateView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null && args['isEdit'] == true) {
        final jobCreateVM =
            Provider.of<JobCreateViewModel>(context, listen: false);
        jobCreateVM.setJobEditOption(true);
        if (args['jobId'] != null) {
          jobCreateVM.setJobId(args['jobId']);
        }
        if (args['loadJobData'] != null) {
          jobCreateVM.loadJobData(args['loadJobData']);
        }
      }
      initilizeTheProfileData();
    });
  }

  initilizeTheProfileData() async {
    final jobCreateVM = Provider.of<JobCreateViewModel>(context, listen: false);
    await jobCreateVM.initializeTheData();
  }

  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);
    final jobListingVM = Provider.of<JobListingsViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () {
              showAlertMessage(
                context,
                'Do you really want to go back, delete data if you back?',
                onBack: () async {
                  navigationService.goBack();
                  navigationService.goBack();
                },
              );
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Create New Job",
          style: TextStyles.medium2(),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await jobCreateVM.setJobPreviewData();
              navigationService.navigateToWithParams(RouteList.jobdetailsScreen,
                  params: jobCreateVM.createJobPreviewData);
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
              jobCreateVM.currentStep, jobCreateVM.totalSteps, jobCreateVM),
          Expanded(
            child: PageView(
              controller: jobCreateVM.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                jobCreateVM.totalSteps,
                (index) => _buildStep(
                    JobCreateSteps.values[index], jobCreateVM.formKeys[index]),
              ),
            ),
          ),
          _bottomButtons(context, jobCreateVM, jobListingVM),
        ],
      ),
    );
  }

  Widget _buildStepProgressBar(
      currentStep, totalSteps, JobCreateViewModel jobcreateVm) {
    return StepsView(
      currentStep: jobcreateVm.currentStep,
      totalSteps: jobcreateVm.totalSteps,
    );
  }

  Widget _buildStep(JobCreateSteps stepIndex, GlobalKey<FormState> key) {
    return Form(
      key: key,
      child: _getStepWidget(stepIndex),
    );
  }

  Widget _getStepWidget(JobCreateSteps stepIndex) {
    switch (stepIndex) {
      case JobCreateSteps.JOBINFO:
        return JobInfo();
      case JobCreateSteps.LOGOANDBANNER:
        return LogoAndBannerView();
      case JobCreateSteps.JOBLOCATION:
        return JobLocationView();
      case JobCreateSteps.OTHERINFO:
        return OtherInfoView();
      case JobCreateSteps.PAY:
        return PayDetails();
      case JobCreateSteps.OTHERLINKS:
        return OtherLinksView();
      default:
        return Center(child: Text("Step \${stepIndex.value + 1}"));
    }
  }

  Widget _bottomButtons(BuildContext context, JobCreateViewModel jobCreateVM,
      JobListingsViewModel jobListingVM) {
    int currentStep = jobCreateVM.currentStep;
    bool isLastStep = currentStep == jobCreateVM.totalSteps - 1;
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
          if (!isFirstStep)
            Expanded(
              child: CustomRoundedButton(
                fontSize: 12,
                text: 'Previous',
                height: 42,
                onPressed: () {
                  jobCreateVM.goToPreviousStep();
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
                (jobCreateVM.jobEditOptionEnable)
                    ? await jobCreateVM.updateJobListing(
                        context, true, jobCreateVM.jobId ?? "")
                    : await jobCreateVM.createdJobListing(context, true);
                //jobListingVM.selectedStatus = "All";
                await jobListingVM.getMyJobListingData(context);

                navigationService.goBack();
                Loaders.circularHideLoader(context);
                scaffoldMessenger("Course is Saved to Draft");
              },
              backgroundColor: AppColors.timeBgColor,
              textColor: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: CustomRoundedButton(
              text: isLastStep
                  ? (jobCreateVM.jobEditOptionEnable ? 'Update' : 'Submit')
                  : 'Next',
              height: 42,
              fontSize: 12,
              onPressed: () async {
                if (jobCreateVM.jobEditOptionEnable) {
                  final currentFormKey =
                      jobCreateVM.formKeys[jobCreateVM.currentStep];
                  if (currentFormKey.currentState?.validate() ?? false) {
                    if (isLastStep) {
                      await jobCreateVM.updateJobListing(
                          context, false, jobCreateVM.jobId ?? "");
                      //jobListingVM.selectedStatus = "All";
                      await jobListingVM.getMyJobListingData(context);
                      navigationService.goBack();
                      Loaders.circularHideLoader(context);
                      scaffoldMessenger("Job updated successfully");
                    } else {
                      jobCreateVM.goToNextStep();
                    }
                  }
                } else {
                  final currentFormKey =
                      jobCreateVM.formKeys[jobCreateVM.currentStep];
                  if (currentFormKey.currentState?.validate() ?? false) {
                    if (isLastStep) {
                      await jobCreateVM.createdJobListing(context, false);
                      //jobListingVM.selectedStatus = "All";
                      await jobListingVM.getMyJobListingData(context);
                      navigationService.goBack();
                      Loaders.circularHideLoader(context);
                      scaffoldMessenger("Job submitted successfully");
                    } else {
                      jobCreateVM.goToNextStep();
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
