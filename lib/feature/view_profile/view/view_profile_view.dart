import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/view_profile/view/sub_views.dart/basic_info.dart';
import 'package:di360_flutter/feature/view_profile/view/sub_views.dart/contact_info.dart';
import 'package:di360_flutter/feature/view_profile/view/sub_views.dart/other_info.dart';
import 'package:di360_flutter/feature/view_profile/view/sub_views.dart/personal_details.dart';
import 'package:di360_flutter/feature/view_profile/view/sub_views.dart/professional_details.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/utils/view_profile_enum.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProfileView extends StatelessWidget with BaseContextHelpers {
  const ViewProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewProfileVM = Provider.of<ViewProfileViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarTitleBackIconWidget(title: 'View Profile'),
      body: Column(
        children: [
          profileStepsWidget(viewProfileVM),
          Expanded( 
            child: PageView(
              controller: viewProfileVM.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                viewProfileVM.totalSteps,
                (index) => _buildStep(
                  ViewProfileSteps.values[index],
                  viewProfileVM.formKeys[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox profileStepsWidget(ViewProfileViewModel viewProfileVM) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewProfileVM.statuses.length,
        itemBuilder: (context, index) {
          final status = viewProfileVM.statuses[index];
          final isSelected = viewProfileVM.selectedStatus == status;
          return GestureDetector(
            onTap: () => viewProfileVM.changeStatus(status),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Text(
                status,
                style: TextStyles.regular2(
                  color: isSelected ? AppColors.whiteColor : AppColors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStep(ViewProfileSteps stepIndex, GlobalKey<FormState> key) {
    return Form(
      key: key,
      child: _getStepWidget(stepIndex),
    );
  }

  Widget _getStepWidget(ViewProfileSteps stepIndex) {
    switch (stepIndex) {
      case ViewProfileSteps.BASICINFO:
        return BasicInfo();
      case ViewProfileSteps.PERSONALDETAILS:
        return PersonalDetails();
        case ViewProfileSteps.CONTACTINFORMATION:
        return ContactInfo();
        case ViewProfileSteps.PROFESSIONALDETAILS:
        return ProfessionalDetails();
        case ViewProfileSteps.OTHERINFO:
        return OtherInfo();

      default:
        return Center(child: Text("Step ${stepIndex.index + 1}"));
    }
  }
}
