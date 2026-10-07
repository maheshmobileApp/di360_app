import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/job_profile_listing/view/job_profile_request_card.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InterestedScreen extends StatelessWidget {
  const InterestedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JobProfileListingViewModel>(context);
    final int requestCount = vm.hiringTalentList?.jobhirings?.length ?? 0;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
              onPressed: () {
                navigationService.goBack();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            "Requests",
            style: TextStyles.bold3(),
          )),
      body: requestCount == 0
          ? Center(
              child: Text(
                "No requests available at the moment",
                style: TextStyles.medium2(color: AppColors.black),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: requestCount,
              itemBuilder: (context, index) {
                return JobProfileRequestCard(
                    jobsListingData: vm.hiringTalentList?.jobhirings?[index],
                    index: index,
                    type: vm.requestType,
                    professionalId:
                        vm.allJobProfiles.first.dentalProfessionalId ?? "");
              },
            ),
    );
  }
}
