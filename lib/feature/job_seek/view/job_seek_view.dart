import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_seek/view/job_seek_card.dart';
import 'package:di360_flutter/feature/job_seek/view/tab_switch.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/feature/talents/views/talents_view.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class JobSeekView extends StatefulWidget {
  const JobSeekView({Key? key}) : super(key: key);

  @override
  State<JobSeekView> createState() => _JobSeekViewState();
}

class _JobSeekViewState extends State<JobSeekView> with BaseContextHelpers {
  @override
  void initState() {
    final provider = Provider.of<JobSeekViewModel>(context, listen: false);
    provider.toggleFloatingButtonVisibility();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobSeekViewModel>(
      builder: (context, jobSeekViewModel, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            title: Stack(
              clipBehavior: Clip.none,
              children: [
                Text(
                  'Dental Interface',
                  style: TextStyles.bold4(color: AppColors.black),
                ),
                Positioned(
                  top: -9,
                  right: -18,
                  child: SvgPicture.asset(
                    ImageConst.logo,
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
            actions: [
              SvgPicture.asset(ImageConst.notification, color: AppColors.black),
              addHorizontal(15),
              SvgPicture.asset(ImageConst.search, color: AppColors.black),
              addHorizontal(15),
              GestureDetector(
                onTap: () => navigationService
                    .navigateTo(RouteList.JobSeekFilterScreen),
                child: SvgPicture.asset(ImageConst.filter, color: AppColors.black),
              ),
              addHorizontal(15),
            ],
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: getSize(context).height * 0.25,
                decoration: const BoxDecoration(color: AppColors.geryColor),
                child: Image.asset(
                  ImageConst.jobHeaderPng,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: jobSeekViewModel.selectedTabIndex == 0
                    ? _buildJobsList(jobSeekViewModel)
                    : const TalentsView(),
              ),
            ],
          ),
    
          floatingActionButton:
              jobSeekViewModel.isHidleFolatingButton == false
                  ? const TabSwitch()
                  : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildJobsList(JobSeekViewModel vm) {
  return RefreshIndicator(
    onRefresh: () async => await vm.refreshJobs(context),
    child: vm.jobs.isEmpty
        ? Center(
            child: vm.isRefreshing
                ? const CircularProgressIndicator()
                : const Text(""),
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 80), 
            child: ListView.builder(
              itemCount: vm.jobs.length,
              itemBuilder: (context, index) {
                final jobData = vm.jobs[index];
                return InkWell(
                  onTap: () {
                    navigationService.navigateToWithParams(
                      RouteList.jobdetailsScreen,
                      params: jobData,
                    );
                  },
                  child: JobSeekCard(jobsData: jobData),
                );
              },
            ),
          ),
  );
}

}
