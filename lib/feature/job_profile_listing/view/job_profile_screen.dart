import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile_listing/view/job_profile_card.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/notifaction_panel.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobProfileScreen extends StatefulWidget {
  const JobProfileScreen({super.key});
  @override
  State<JobProfileScreen> createState() => _JobProfileListingScreenState();
}

class _JobProfileListingScreenState extends State<JobProfileScreen>
    with BaseContextHelpers {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JobProfileListingViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColor,
        icon: Icon(
          vm.allJobProfiles.isEmpty ? Icons.add : Icons.edit,
          color: Colors.white,
        ),
        label: Text(
          vm.allJobProfiles.isEmpty ? "Create Profile" : "Edit Profile",
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          //await vm.fetchJobProfiles();
          if (vm.allJobProfiles.isEmpty) {
            vm.setEditProfileEnable(false);
            await navigationService.navigateTo(RouteList.JobProfileView);
            //await vm.fetchJobProfiles();
          } else {
            final profileData = vm.allJobProfiles.first;
            print("Edit preload data: $profileData");
            vm.setEditProfileEnable(true);
            await navigationService
                .navigateToWithParams(RouteList.JobProfileView, params: {
              "profileData": profileData,
              "isEdit": true,
            });
          }
        },
      ),
      endDrawer: NotificationsPanel(),
      appBar: AppBarWidget(
          searchWidget: false,),
      body: Column(
        children: [
          Expanded(
            child: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : vm.allJobProfiles.isEmpty
                    ? Center(
                        child: Text(
                          "No Profiles Found",
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                      )
                    : ListView.builder(
                        itemCount: vm.allJobProfiles.length,
                        itemBuilder: (context, index) {
                          final jobData = vm.allJobProfiles[index];
                          return JobProfileCard(
                            jobsListingData: jobData,
                            vm: vm,
                            index: index,
                            parmas: {},
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
