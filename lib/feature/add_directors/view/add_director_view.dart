import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_appoinment.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_archiement.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_basic_info.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_certificate.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_document.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_fqs.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_gallery.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_services.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_team_member.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_testmonal.dart';
import 'package:di360_flutter/feature/add_directors/view/other_information_screen.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/view/steps_view.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/add_directory_enum.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorView extends StatelessWidget with BaseContextHelpers {
  AddDirectorView({super.key});
  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              NavigationService().goBack();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Add New Directory",
          style: TextStyles.medium2(),
        )
      ),
      body: Column(
        children: [
          _buildStepProgressBar(addDirectorVM.currentStep,
              addDirectorVM.totalSteps, addDirectorVM),
          Expanded(
            child: PageView(
              controller: addDirectorVM.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                addDirectorVM.totalSteps,
                (index) => _buildStep(AddDirectoryStep.values[index],
                    addDirectorVM.formKeys[index]),
              ),
            ),
          ),
          _bottomButtons(context, addDirectorVM),
        ],
      ),
    );
  }

  Widget _buildStepProgressBar(
      currentStep, totalSteps, AddDirectorViewModel AddDirectorVM) {
    return StepsView(
        currentStep: AddDirectorVM.currentStep,
        totalSteps: AddDirectorVM.totalSteps);
  }

  Widget _buildStep(AddDirectoryStep stepIndex, GlobalKey<FormState> key) {
    return Form(
      key: key,
      child: _getStepWidget(stepIndex),
    );
  }

  Widget _getStepWidget(AddDirectoryStep stepIndex) {
    switch (stepIndex) {
      case AddDirectoryStep.Basic:
        return AddDirectorBasicInfo();
      case AddDirectoryStep.Services:
        return AddDirectorService();
      case AddDirectoryStep.Certificates:
        return AddDirectorCertificate();
      case AddDirectoryStep.Achievements:
        return AddDirectorAchievement();
      case AddDirectoryStep.Documents:
        return AddDirectorDocument();
      case AddDirectoryStep.OurTeam:
        return AddDirectorTeamMember();
      case AddDirectoryStep.Gallery:
        return AddDirectorGallery();
      case AddDirectoryStep.Appointments:
        return AddDirectorAppoinment();
      case AddDirectoryStep.Faqs:
        return AddDirectorFqs();
      case AddDirectoryStep.Testimonials:
        return AddDirectorTestmonal();
      case AddDirectoryStep.OtherInformation:
        return OtherInformationScreen();
      default:
        return Center(child: Text("Step ${stepIndex.value + 1}"));
    }
  }

  Widget _bottomButtons(
      BuildContext context, AddDirectorViewModel addDirectorVM) {
    int currentStep = addDirectorVM.currentStep;
    bool isLastStep = currentStep == addDirectorVM.totalSteps - 1;
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
                  addDirectorVM.goToPreviousStep();
                },
                backgroundColor: AppColors.geryColor,
                textColor: Colors.black,
              ),
            ),
          if (!isFirstStep) const SizedBox(width: 16),
          Expanded(
            child: CustomRoundedButton(
              fontSize: 12,
              text: 'Skip',
              height: 42,
              onPressed: () {
                addDirectorVM.goToNextStep();
              },
              backgroundColor: AppColors.timeBgColor,
              textColor: AppColors.primaryColor
            ),
          ),
          addHorizontal(16),
          Expanded(
            child: CustomRoundedButton(
                text: isLastStep ? 'Submit' : 'Next',
                height: 42,
                fontSize: 12,
                onPressed: () async {
                  final currentFormKey =
                      addDirectorVM.formKeys[addDirectorVM.currentStep];
                  if ((currentFormKey.currentState?.validate() ?? false) &&
                      addDirectorVM.selectedBusineestype != null) {
                    if (isLastStep) {
                      navigationService.goBack();
                    } else {
                      if (currentStep == 0) {
                        addDirectorVM.getBasicInfoData.isEmpty
                            ? await addDirectorVM.addBasicInfo(context)
                            : await addDirectorVM.updateBasicInfo(context);
                        addDirectorVM.goToNextStep();
                      } else {
                        addDirectorVM.goToNextStep();
                      }
                    }
                  } else {
                    scaffoldMessenger('Please select business type');
                  }
                },
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }
}

Widget sectionHeader(String title) {
  return Text(
    title,
    style: TextStyles.clashMedium(color: AppColors.buttonColor),
  );
}
