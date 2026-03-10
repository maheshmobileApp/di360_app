import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_appoinment.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_archiement.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_basic_info.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_certificate.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_document.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_fqs.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_gallery.dart';
import 'package:di360_flutter/feature/add_directors/view/get_director_partners.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_services.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_team_member.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_testmonal.dart';
import 'package:di360_flutter/feature/add_directors/view/other_information_screen.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/view/steps_view.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/add_directory_enum.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorView extends StatelessWidget with BaseContextHelpers {
  AddDirectorView({super.key});
  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    return FutureBuilder<String?>(
      future: LocalStorage.getStringVal(LocalStorageConst.type),
      builder: (context, snapshot) {
        final userType = snapshot.data;
        return _buildContent(context, addDirectorVM, userType);
      },
    );
  }

  Widget _buildContent(BuildContext context, AddDirectoryViewModel addDirectorVM, String? userType) {
    final isPractice = userType == UserRole.practice.value;
    final steps = AddDirectoryStep.values.where((step) => 
      !isPractice || step != AddDirectoryStep.Partners
    ).toList();
    final totalSteps = steps.length;
    
    return WillPopScope(
        onWillPop: () async {
          final directorComplete = await LocalStorage.getBoolValue(
              LocalStorageConst.directoryComplete);
          final firstNavigation = await LocalStorage.getBoolValue(
              LocalStorageConst.firstNavigationDirectory);
          if (addDirectorVM.getBasicInfoData.isEmpty) {
            await viewProfileAlertPopup(context,
                title: 'Please complete your Directory Profile',
                subTitle:
                    'This profile is visible in the Marketplace and must be filled and saved to continue using your services');
            return false;
          } else if (directorComplete == true && firstNavigation == false) {
            navigationService.goBack();
            return true;
          } else {
            navigationService.pushNamedAndRemoveUntil(RouteList.dashBoard);
            return false;
          }
        },
        child: Scaffold(
          appBar: AppbarTitleBackIconWidget(
              title: 'Add My Directory',
              backAction: () async {
                final directorComplete = await LocalStorage.getBoolValue(
                    LocalStorageConst.directoryComplete);
                final firstNavigation = await LocalStorage.getBoolValue(
                    LocalStorageConst.firstNavigationDirectory);
                return addDirectorVM.getBasicInfoData.isEmpty
                    ? viewProfileAlertPopup(context,
                        title: 'Please complete your Directory Profile',
                        subTitle:
                            'This profile is visible in the Marketplace and must be filled and saved to continue using your services')
                    : (directorComplete == true && firstNavigation == false)
                        ? navigationService.goBack()
                        : navigationService
                            .pushNamedAndRemoveUntil(RouteList.dashBoard);
              }),
          body: Column(
            children: [
              _buildStepProgressBar(addDirectorVM.currentStep,
                  totalSteps, addDirectorVM),
              Expanded(
                child: PageView(
                  controller: addDirectorVM.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                    totalSteps,
                    (index) => _buildStep(steps[index],
                        addDirectorVM.formKeys[steps[index].value]),
                  ),
                ),
              ),
              _bottomButtons(context, addDirectorVM, totalSteps),
            ],
          ),
        ));
  }

  Widget _buildStepProgressBar(
      currentStep, totalSteps, AddDirectoryViewModel AddDirectorVM) {
    return StepsView(
        currentStep: AddDirectorVM.currentStep,
        totalSteps: totalSteps);
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
      case AddDirectoryStep.Partners:
        return GetDirectorPartners();
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
    }
  }

  Widget _bottomButtons(
      BuildContext context, AddDirectoryViewModel addDirectorVM, int totalSteps) {
    int currentStep = addDirectorVM.currentStep;
    bool isLastStep = currentStep == totalSteps - 1;
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
                onPressed: () async {
                  final currentFormKey =
                      addDirectorVM.formKeys[addDirectorVM.currentStep];
                  if (currentStep == 0) {
                    if (!(currentFormKey.currentState?.validate() ?? false)) {
                      return;
                    }
                    if (addDirectorVM.selectedBusineestype == null) {
                      scaffoldMessenger('Please select business type');
                      return;
                    }
                    if (addDirectorVM.getBasicInfoData.isEmpty) {
                      if (addDirectorVM.logoFile == null) {
                        scaffoldMessenger('Please upload logo');
                        return;
                      }
                      if (addDirectorVM.bannerFile == null) {
                        scaffoldMessenger('Please upload banner image');
                        return;
                      }
                    } else {
                      final hasLogo = addDirectorVM.logoFile != null ||
                          (addDirectorVM.getBasicInfoData.first.logo?.url
                                  ?.isNotEmpty ??
                              false);
                      final hasBanner = addDirectorVM.bannerFile != null ||
                          (addDirectorVM.getBasicInfoData.first.bannerImage?.url
                                  ?.isNotEmpty ??
                              false);
                      if (!hasLogo) {
                        scaffoldMessenger('Please upload logo');
                        return;
                      }
                      if (!hasBanner) {
                        scaffoldMessenger('Please upload banner image');
                        return;
                      }
                    }
                    addDirectorVM.getBasicInfoData.isEmpty
                        ? await addDirectorVM.addBasicInfo(context)
                        : addDirectorVM.goToNextStep();
                  } else {
                    if (isLastStep) {
                      navigationService.goBack();
                    } else {
                      addDirectorVM.goToNextStep();
                    }
                  }
                },
                backgroundColor: AppColors.timeBgColor,
                textColor: AppColors.primaryColor),
          ),
          addHorizontal(16),
          Expanded(
            child: CustomRoundedButton(
                text: isLastStep ? 'Submit' : 'Save & Next',
                height: 42,
                fontSize: 12,
                onPressed: () async {
                  final currentFormKey =
                      addDirectorVM.formKeys[addDirectorVM.currentStep];
                  if (currentStep == 0) {
                    if (!(currentFormKey.currentState?.validate() ?? false)) {
                      return;
                    }
                    if (addDirectorVM.selectedBusineestype == null) {
                      scaffoldMessenger('Please select business type');
                      return;
                    }
                    if (addDirectorVM.getBasicInfoData.isEmpty) {
                      if (addDirectorVM.logoFile == null) {
                        scaffoldMessenger('Please upload logo');
                        return;
                      }
                      if (addDirectorVM.bannerFile == null) {
                        scaffoldMessenger('Please upload banner image');
                        return;
                      }
                    } else {
                      final hasLogo = addDirectorVM.logoFile != null ||
                          (addDirectorVM.getBasicInfoData.first.logo?.url
                                  ?.isNotEmpty ??
                              false);
                      final hasBanner = addDirectorVM.bannerFile != null ||
                          (addDirectorVM.getBasicInfoData.first.bannerImage?.url
                                  ?.isNotEmpty ??
                              false);
                      if (!hasLogo) {
                        scaffoldMessenger('Please upload logo');
                        return;
                      }
                      if (!hasBanner) {
                        scaffoldMessenger('Please upload banner image');
                        return;
                      }
                    }
                    addDirectorVM.getBasicInfoData.isEmpty
                        ? await addDirectorVM.addBasicInfo(context)
                        : await addDirectorVM.updateBasicInfo(context);
                    addDirectorVM.goToNextStep();
                    await addDirectorVM.getDirectories();
                  } else {
                    if (isLastStep) {
                      navigationService.goBack();
                    } else {
                      addDirectorVM.goToNextStep();
                    }
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
