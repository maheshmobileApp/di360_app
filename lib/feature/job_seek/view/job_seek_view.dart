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
  final ScrollController _jobsScrollController = ScrollController();

  @override
  void initState() {
    final provider = Provider.of<JobSeekViewModel>(context, listen: false);
    provider.toggleFloatingButtonVisibility();
    _jobsScrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_jobsScrollController.position.pixels >=
        _jobsScrollController.position.maxScrollExtent - 100) {
      final provider = Provider.of<JobSeekViewModel>(context, listen: false);
      provider.fetchJobsForSelectedTab(context, loadMore: true);
    }
  }

  @override
  void dispose() {
    _jobsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JobSeekViewModel>(context);
    return Consumer<JobSeekViewModel>(
      builder: (context, jobSeekViewModel, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarWidget(
              searchWidget: false,
              filterWidget: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (jobSeekViewModel.selectedTabIndex == 0) {
                        navigationService.navigateTo(RouteList.JobSeekFilterScreen);
                      } else {
                        navigationService.navigateTo(RouteList.TalentFliterScreen);
                      }
                    },
                    child:
                        SvgPicture.asset(ImageConst.filter, color: AppColors.black),
                  ),
                  if (vm.jobSeekFilterApply == true)
              GestureDetector(
                  onTap: () => vm.clearSelections(context),
                  child: Icon(Icons.close, color: AppColors.black))
                ],
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
      backgroundColor: AppColors.whiteColor,
      onRefresh: () async => await vm.refreshJobs(context),
      child: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.jobs.isEmpty
              ? const Center(child: Text("No Jobs Available"))
              : GenericListViewWithBanners<Jobs>(
                  controller: _jobsScrollController,
                  items: vm.jobs,
                  bannerIndices:
                      BannerUtils.calculateBannerIndices(vm.jobs.length),
                  itemBuilder: (context, dataIndex) {
                    final jobData = vm.jobs[dataIndex];
                    final jobId = vm.jobs[dataIndex].id ?? "";

                    return InkWell(
                      onTap: () async {
                        await vm.getJobDetails(jobId, context);
                        if (vm.jobDetailsById != [])
                        navigationService.navigateToWithParams(
                          RouteList.jobdetailsScreen,
                          params: vm.jobDetailsById.first,
                        );
                      },
                      child: JobSeekCard(jobsData: jobData),
                    );
                  },
                  bannerBuilder: (context, bannerPos) {
                    return ListBanner();
                  },
                  loadingWidget: vm.hasMoreJobs && vm.isLoadingMore
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.primaryColor)),
                        )
                      : null,
                ),
    );
  }
}
