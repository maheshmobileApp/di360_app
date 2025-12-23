import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_archiement.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_certificate.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_gallery.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_testmonal.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/view/steps_view.dart';
import 'package:di360_flutter/feature/professional_add_director/view/add_profess_director/edution_screen.dart';
import 'package:di360_flutter/feature/professional_add_director/view/add_profess_director/other_infor_screen.dart';
import 'package:di360_flutter/feature/professional_add_director/view/add_profess_director/profess_basic_info.dart';
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/add_directory_enum.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfessionalAddDirectorView extends StatelessWidget
    with BaseContextHelpers {
  ProfessionalAddDirectorView({super.key});
  @override
  Widget build(BuildContext context) {
    final professAddDirectVM = Provider.of<ProfessionalAddDirectorVm>(context);
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    return Scaffold(
      appBar: AppbarTitleBackIconWidget(title: 'Add New Directory'),
      body: Column(
        children: [
          _buildStepProgressBar(professAddDirectVM.currentStep,
              professAddDirectVM.totalSteps, professAddDirectVM),
          Expanded(
            child: PageView(
              controller: professAddDirectVM.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                professAddDirectVM.totalSteps,
                (index) => _buildStep(ProfessAddDirectoryStep.values[index],
                    professAddDirectVM.formKeys[index]),
              ),
            ),
          ),
          _bottomButtons(context, professAddDirectVM, addDirectorVM),
        ],
      ),
    );
  }

  Widget _buildStepProgressBar(
      currentStep, totalSteps, ProfessionalAddDirectorVm professAddDirectVM) {
    return StepsView(
        currentStep: professAddDirectVM.currentStep,
        totalSteps: professAddDirectVM.totalSteps);
  }

  Widget _buildStep(
      ProfessAddDirectoryStep stepIndex, GlobalKey<FormState> key) {
    return Form(
      key: key,
      child: _getStepWidget(stepIndex),
    );
  }

  Widget _getStepWidget(ProfessAddDirectoryStep stepIndex) {
    switch (stepIndex) {
      case ProfessAddDirectoryStep.Basic:
        return ProfessBasicInfo();
      case ProfessAddDirectoryStep.Education:
        return EducationScreen();
      case ProfessAddDirectoryStep.Certificates:
        return AddDirectorCertificate();
      case ProfessAddDirectoryStep.Achievements:
        return AddDirectorAchievement();
      case ProfessAddDirectoryStep.Gallery:
        return AddDirectorGallery();
      case ProfessAddDirectoryStep.Testimonials:
        return AddDirectorTestmonal();
      case ProfessAddDirectoryStep.OtherInformation:
        return OtherInforScreen();
      default:
        return Center(child: Text("Step ${stepIndex.value + 1}"));
    }
  }

  Widget _bottomButtons(
      BuildContext context,
      ProfessionalAddDirectorVm professAddDirectVM,
      AddDirectoryViewModel addDirectorVM) {
    int currentStep = professAddDirectVM.currentStep;
    bool isLastStep = currentStep == professAddDirectVM.totalSteps - 1;
    bool isFirstStep = currentStep == 0;
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5.0)
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
                    professAddDirectVM.goToPreviousStep();
                  },
                  backgroundColor: AppColors.geryColor,
                  textColor: Colors.black),
            ),
          if (!isFirstStep) const SizedBox(width: 16),
          Expanded(
            child: CustomRoundedButton(
                fontSize: 12,
                text: 'Skip',
                height: 42,
                onPressed: () {
                  professAddDirectVM.goToNextStep();
                },
                backgroundColor: AppColors.timeBgColor,
                textColor: AppColors.primaryColor),
          ),
          addHorizontal(14),
          Expanded(
            child: CustomRoundedButton(
                text: isLastStep ? 'Submit' : 'Save&Next',
                height: 42,
                fontSize: 11,
                onPressed: () async {
                  final currentFormKey = professAddDirectVM
                      .formKeys[professAddDirectVM.currentStep];
                  if ((currentFormKey.currentState?.validate() ?? false)) {
                    if (isLastStep) {
                      scaffoldMessenger('Submitted Successfully');
                      navigationService.goBack();
                    } else {
                      if (currentStep == 0) {
                        addDirectorVM.getBasicInfoData.first.id?.isEmpty ??
                                false
                            ? await professAddDirectVM.addBasicData(context)
                            : await professAddDirectVM.updateBasicData(context);
                        professAddDirectVM.goToNextStep();
                      } else if (currentStep == 1) {
                        await professAddDirectVM.updateBasicData(context);
                        professAddDirectVM.goToNextStep();
                      } else {
                        professAddDirectVM.goToNextStep();
                      }
                    }
                  } else {
                    //scaffoldMessenger('Please select business type');
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
