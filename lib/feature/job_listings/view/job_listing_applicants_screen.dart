import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_applicants_card.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class JobListingApplicantsScreen extends StatefulWidget {
  final Jobs? jobsListingData;
  const JobListingApplicantsScreen({super.key, this.jobsListingData});

  @override
  State<JobListingApplicantsScreen> createState() =>
      _JobListingApplicantsScreenState();
}

class _JobListingApplicantsScreenState extends State<JobListingApplicantsScreen>
    with BaseContextHelpers {
  @override
  void initState() {
    super.initState();
    // If you need to fetch data here:
    // Future.microtask(() => Provider.of<JobSeekViewModel>(context, listen: false).fetchJobs(context));
  }

  @override
  Widget build(BuildContext context) {
    final jobListingVM = Provider.of<JobListingsViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: _logoWithTitle(
          context,
          widget.jobsListingData?.logo ?? '',
          widget.jobsListingData?.companyName ?? '',
          widget.jobsListingData?.jRole ?? '',
          widget.jobsListingData?.title ?? '',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: jobListingVM.statusesforapplicatnts.length,
              itemBuilder: (context, index) {
                String status = jobListingVM.statusesforapplicatnts[index];
                bool isSelected =
                    jobListingVM.selectedstatusesforapplicatnts == status;
                return GestureDetector(
                  onTap: () {
                    jobListingVM.changeStatusforapplicatnts(status, context);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
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
          const Divider(),
          Expanded(
            child: jobListingVM.myApplicantsList.isEmpty
                ? Center(
                    child: Text(
                      " No Applicants found",
                      style: TextStyles.medium2(color: AppColors.black),
                    ),
                  )
                : ListView.builder(
                    itemCount: jobListingVM.myApplicantsList.length,
                    itemBuilder: (context, index) {
                      final jobData = jobListingVM.myApplicantsList[index];
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

  Widget _logoWithTitle(
  BuildContext context,
  String logo,
  String company,
  String title,
  String jobTitle
) {
  return Row(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.geryColor,
         
            radius: 30,
            child: CachedNetworkImageWidget(
                                      imageUrl: logo ??
                                          '',
                                      fit: BoxFit.fill,
                                      errorWidget:
                                          Image.asset(ImageConst.prfImg)),
          ),
        ],
      ),
      addHorizontal(12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(company,
                style: TextStyles.medium2(color: AppColors.black)),
              addVertical(2),
              Text(jobTitle,
                  style: TextStyles.regular2(color: AppColors.black)),
            addVertical(2),
            Text(title,
                style: TextStyles.regular2(color: AppColors.black)),
          ],
        ),
      ),
    ],
  );
}

}

