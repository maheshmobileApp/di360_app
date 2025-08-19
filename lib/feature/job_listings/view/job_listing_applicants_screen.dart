import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_applicants_card.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class JobListingApplicantsScreen extends StatefulWidget {
  const  JobListingApplicantsScreen({super.key});

  @override
  State< JobListingApplicantsScreen> createState() => _JobListingApplicantsScreenState();
}

class _JobListingApplicantsScreenState extends State<JobListingApplicantsScreen>
    with BaseContextHelpers {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() => Provider.of<JobSeekViewModel>(context, listen: false)
    //     .fetchJobs(context));
  }

  @override
  Widget build(BuildContext context) {
      final jobListingVM = Provider.of<JobListingsViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             "Job Title Name",
              style: TextStyles.semiBold(color: AppColors.black, fontSize: 16),
            ),
            addVertical(2),
            Text(
              "Company Name",
              style: TextStyles.regular1(
                  color: AppColors.bottomNavUnSelectedColor, fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert,
                color: AppColors.bottomNavUnSelectedColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:jobListingVM.statusesforapplicatnts.length,
                itemBuilder: (context, index) {
                  String status = jobListingVM.statusesforapplicatnts[index];
                  bool isSelected = jobListingVM.selectedstatusesforapplicatnts == status;
                  return GestureDetector(
                    onTap: () {
                      jobListingVM.changeStatusforapplicatnts(status, context);
                    },
                    child: Container(
                      margin:  EdgeInsets.symmetric(
                          horizontal: 3, vertical: 10),
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
                               "${jobListingVM.statusCountMapforapplicatnts[status]}",
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
                            "No Jobs Found",
                            style: TextStyles.medium2(color: AppColors.black),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: jobListingVM.myJobListingList.length,
                      itemBuilder: (context, index) {
                        final jobData = jobListingVM.myJobListingList[index];
                        print( jobListingVM.myJobListingList.length);
                        return JobListingApplicantsCard(
                          jobsListingData: jobData,
                          vm: jobListingVM,
                          index: index,
                        );
                      },
                    ),
            ),
          ],
        ),
    );
  }
    }