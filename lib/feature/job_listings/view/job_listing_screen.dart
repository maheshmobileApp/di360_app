import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listings_card_widget.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class JobListingScreen extends StatefulWidget {
  const JobListingScreen({super.key});

  @override
  State<JobListingScreen> createState() => _JobListingScreenState();
}


class _JobListingScreenState extends State<JobListingScreen>
    with BaseContextHelpers {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final vm = Provider.of<JobListingsViewModel>(context, listen: false);
        vm.getMyJobListingData(context, reset: false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobListingVM = Provider.of<JobListingsViewModel>(context);
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBarWidget(searchWidget: false),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: jobListingVM.statuses.length,
                itemBuilder: (context, index) {
                  String status = jobListingVM.statuses[index];
                  bool isSelected = jobListingVM.selectedStatus == status;
                  return GestureDetector(
                    onTap: () {
                      jobListingVM.changeStatus(status, context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Row(
                        children: [
                          Text(
                            status,
                            style: TextStyles.regular2(
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.black,
                            ),
                          ),
                          SizedBox(width: 6),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${jobListingVM.statusCountMap[status]}",
                              style: TextStyles.regular2(
                                color: isSelected
                                    ? AppColors.black
                                    : AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Expanded(
              child: jobListingVM.myJobListingList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getEmptyStateMessage(jobListingVM.selectedStatus),
                            style: TextStyles.medium2(color: AppColors.black),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: jobListingVM.myJobListingList.length +
                          (jobListingVM.isPaginating ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == jobListingVM.myJobListingList.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final jobData = jobListingVM.myJobListingList[index];
                        return JobListingCard(
                            jobsListingData: jobData,
                            vm: jobListingVM,
                            index: index,
                            jobCreateVM: jobCreateVM);
                      },
                    ),
            ),
          ],
        ),
        /*floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
            await navigationService.navigateTo(RouteList.jobCreate);
          },
          child: SvgPicture.asset(ImageConst.addFeed),
        )*/);
  }

  String _getEmptyStateMessage(String status) {
    switch (status) {
      case 'All':
        return 'No job listings available.';
      case 'Draft':
        return 'No draft jobs available at the moment.';
      case 'Pending Approval':
        return 'No jobs pending approval at the moment.';
      case 'Active':
        return 'No active jobs available at the moment.';
      case 'InActive':
        return 'No inactive jobs available at the moment.';
      case 'Expired':
        return 'No expired jobs available at the moment.';
      case 'Reject':
        return 'No rejected jobs available at the moment.';
      default:
        return 'No job listings with status "$status".';
    }
  }
}
