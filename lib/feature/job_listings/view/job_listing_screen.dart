import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/courses_listing_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
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
  Widget build(BuildContext context) {
    final jobListingVM = Provider.of<JobListingsViewModel>(context);
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);

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
                        return CouresListingCard(
                          id: jobData.id ?? "",
                          meetingLink: "",
                          logoUrl: jobData.logo ?? '',
                          companyName: jobData.title ?? '',
                          courseTitle: jobData.companyName ?? '',
                          status: jobData.status ?? '',
                          activeStatus: jobData.activeStatus ?? "",
                          description: jobData.description ?? '',
                          types: jobData.typeofEmployment ?? [],
                          createdAt: jobData.createdAt ?? '',
                          registeredCount: jobData
                                  .jobApplicantsAggregate?.aggregate?.count ??
                              0,
                          onDetailView: () async {
                            await navigationService.navigateToWithParams(
                              RouteList.jobdetailsScreen,
                              params: jobListingVM.myJobListingList[index],
                            );
                          },
                          onTapRegistered: () async {
                            jobListingVM.jobId = jobData.id ?? '';
                            await jobListingVM.getMyJobApplicantsgData(
                                context, jobData.id ?? '');
                            navigationService.navigateToWithParams(
                                RouteList.JobListingApplicantscreen,
                                params: jobData);
                          },
                          onMenuAction: (action, id) async {
                            switch (action) {
                              case "Preview":
                                await navigationService.navigateToWithParams(
                                  RouteList.jobdetailsScreen,
                                  params: jobListingVM.myJobListingList[index],
                                );

                                break;
                              case "Edit":
                                jobCreateVM.setJobEditOption(true);
                                jobCreateVM.setJobId(jobData.id ?? "");

                                await jobListingVM.getEditJobIDData(
                                    context, jobData.id ?? "");
                                /*await jobCreateVM
                                    .loadJobData(jobListingVM.jobDataById);*/

                                navigationService.navigateToWithParams(
                                  RouteList.jobCreate,
                                  params: {
                                    'isEdit': true,
                                    'jobId': jobData.id,
                                    'loadJobData': jobListingVM.myJobListingList[index]
                                  },
                                );

                                break;

                              case "Delete":
                                showAlertMessage(context,
                                    'Are you sure you want to delete this job?',
                                    onBack: () {
                                  navigationService.goBack();
                                  jobListingVM.removeJobsListingData(
                                      context, id);
                                });

                                break;
                              /* case "Inactive":
                                courseListingVM.updateCourseStatus(
                                    context, course.id ?? "", "INACTIVE");
                                break;
                              case "Active":
                                courseListingVM.updateCourseStatus(
                                    context, course.id ?? "", "ACTIVE");
                                break;
                              case "Re-Listing":
                                await courseListingVM.getCourseDetails(
                                    context, course.id ?? "");
                                courseListingVM.setEditOption(true);
                                newCourseVM.setCurrentStep(0);
                                courseListingVM.setCourseId(course.id ?? "");
                                newCourseVM.fetchCourseCategory();
                                newCourseVM.fetchCourseType();
                                newCourseVM.setEditMode(true);
                                Loaders.circularShowLoader(context);
                                await loadCourseData(newCourseVM,
                                    courseListingVM.courseDetails.first);
                                newCourseVM.eraseDateFields();

                                Loaders.circularHideLoader(context);
                                navigationService.navigateTo(
                                  RouteList.newCourseScreen,
                                );*/
                            }
                          },
                          chipTitle: 'Applicants',
                        );
                      },
                    ),

              /*ListView.builder(
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
                    ),*/
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
