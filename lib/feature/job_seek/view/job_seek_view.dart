import 'package:di360_flutter/common/banner/generic_list_view_with_banners.dart';
import 'package:di360_flutter/common/banner/list_banner.dart';
import 'package:di360_flutter/common/banner/utils.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/job_seek/view/job_seek_card.dart';
import 'package:di360_flutter/feature/job_seek/view/tab_switch.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/notifaction_panel.dart';
import 'package:di360_flutter/feature/talents/views/talents_view.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
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
          endDrawer: NotificationsPanel(),
          appBar: AppBarWidget(
              filterWidget: GestureDetector(
            onTap: () {
              if (jobSeekViewModel.selectedTabIndex == 0) {
                navigationService.navigateTo(RouteList.JobSeekFilterScreen);
              } else {
                navigationService.navigateTo(RouteList.TalentFliterScreen);
              }
            },
            child: SvgPicture.asset(ImageConst.filter, color: AppColors.black),
          )),
          body: jobSeekViewModel.selectedTabIndex == 0
              ? _buildJobsList(jobSeekViewModel)
              : const TalentsView(),
          floatingActionButton: jobSeekViewModel.isHidleFolatingButton == false
              ? const TabSwitch()
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
                  : const Text("No Jobs Available"),
            )
          : GenericListViewWithBanners<Jobs>(
              items: vm.jobs,
              bannerIndices: BannerUtils.calculateBannerIndices(
                  vm.jobs.length), // Show banners at 0 and 5
              itemBuilder: (context, dataIndex) {
                final jobData = vm.jobs[dataIndex];
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
              bannerBuilder: (context, bannerPos) {
                // bannerPos is 0 for index 0, 1 for index 5, etc.
                return ListBanner();
              },
            ),
    );
  }
}
