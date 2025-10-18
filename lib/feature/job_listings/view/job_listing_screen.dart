import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
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
  @override
  void initState() {
    super.initState();
    // final jobListingVM =
    //     Provider.of<JobListingsViewModel>(context, listen: false);
    // jobListingVM.fetchJobStatusCounts();
  }

  @override
  Widget build(BuildContext context) {
    final jobListingVM = Provider.of<JobListingsViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBarWidget(
            filterWidget: GestureDetector(
          onTap: () =>
              navigationService.navigateTo(RouteList.JobSeekFilterScreen),
          child: SvgPicture.asset(ImageConst.filter, color: AppColors.black),
        )),
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
                            "No Jobs matched your search.",
                            style: TextStyles.medium2(color: AppColors.black),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: jobListingVM.myJobListingList.length,
                      itemBuilder: (context, index) {
                        final jobData = jobListingVM.myJobListingList[index];
                        print(jobListingVM.myJobListingList.length);
                        return JobListingCard(
                          jobsListingData: jobData,
                          vm: jobListingVM,
                          index: index,
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
            await navigationService.navigateTo(RouteList.jobCreate);
            jobListingVM.getMyJobListingData();
          },
          child: SvgPicture.asset(ImageConst.addFeed),
        ));
  }
}
