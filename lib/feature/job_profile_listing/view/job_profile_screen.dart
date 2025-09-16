import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile_listing/view/job_profile_card.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      fetchProfile();
    });
  }

  void fetchProfile() {
    final vm = Provider.of<JobProfileListingViewModel>(context, listen: false);
    vm.fetchJobProfiles();
  }

  @override
  Widget build(BuildContext context) {
    final notificationVM = Provider.of<NotificationViewModel>(context);
    final vm = Provider.of<JobProfileListingViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColor,
        icon: Icon(
          vm.filteredProfiles.isEmpty ? Icons.add : Icons.edit,
          color: Colors.white,
        ),
        label: Text(
          vm.filteredProfiles.isEmpty ? "Create Profile" : "Edit Profile",
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          await vm.fetchJobProfiles();
          if (vm.filteredProfiles.isEmpty) {
            await navigationService.navigateTo(RouteList.JobProfileView);
            await vm.fetchJobProfiles();
          } else {
            await navigationService.navigateTo(
              RouteList.JobProfileView,
            );
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Stack(
          clipBehavior: Clip.none,
          children: [
            Text('Dental Interface',
                style: TextStyles.bold4(color: AppColors.black)),
            Positioned(
              top: -9,
              right: -18,
              child: SvgPicture.asset(ImageConst.logo, height: 20, width: 20),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(ImageConst.notification,
                      color: AppColors.black),
                  if (notificationVM.notificationCount != 0)
                    Positioned(
                      top: -16,
                      right: -13,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColors.primaryColor,
                        child: Text(
                          '${notificationVM.notificationCount}',
                          style:
                              TextStyles.medium1(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          addHorizontal(15),
          SvgPicture.asset(ImageConst.search, color: AppColors.black),
          addHorizontal(15),
          GestureDetector(
            onTap: () =>
                navigationService.navigateTo(RouteList.TalentListingFilter),
            child: SvgPicture.asset(ImageConst.filter, color: AppColors.black),
          ),
          addHorizontal(15),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: vm.statuses.length,
              itemBuilder: (context, index) {
                final status = vm.statuses[index];
                final isSelected = vm.selectedStatus == status.toUpperCase();
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Colors.pink, AppColors.primaryColor],
                          )
                        : null,
                    color: isSelected ? null : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: Text(
                    vm.displayName(status),
                    style: TextStyles.regular2(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.primaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : vm.filteredProfiles.isEmpty
                    ? Center(
                        child: Text(
                          "No Profiles Found",
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                      )
                    : ListView.builder(
                        itemCount: vm.filteredProfiles.length,
                        itemBuilder: (context, index) {
                          final jobData = vm.filteredProfiles[index];
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
