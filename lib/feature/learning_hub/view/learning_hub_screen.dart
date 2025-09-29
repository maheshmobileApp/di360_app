import 'dart:io';

import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/session_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/courses_listing_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LearningHubScreen extends StatefulWidget {
  const LearningHubScreen({super.key});

  @override
  State<LearningHubScreen> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<LearningHubScreen>
    with BaseContextHelpers {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notificationVM = Provider.of<NotificationViewModel>(context);
    final courseListingVM = Provider.of<CourseListingViewModel>(context);
    final newCourseVM = Provider.of<NewCourseViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          title: Stack(
            clipBehavior: Clip.none,
            children: [
              Text(
                'Course Listing',
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
            Builder(
              builder: (context) => GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
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
                                    style: TextStyles.medium1(
                                        color: AppColors.whiteColor))))
                    ],
                  )),
            ),
            addHorizontal(30),
            GestureDetector(
                onTap: () {
                  courseListingVM.setSearchBar(!courseListingVM.searchBarOpen);
                },
                child: SvgPicture.asset(ImageConst.search,
                    color: AppColors.black)),
            addHorizontal(20),
          ],
        ),
        body: Column(
          children: [
            if (courseListingVM.searchBarOpen)
              SearchWidget(
                controller: courseListingVM.searchController,
                hintText: "Search Course...",
                onClear: () {},
                onChanged: (value) {
                  courseListingVM.getCoursesListingData(context, value);
                },
              ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courseListingVM.statuses.length,
                itemBuilder: (context, index) {
                  String status = courseListingVM.statuses[index];
                  bool isSelected = courseListingVM.selectedStatus == status;
                  return GestureDetector(
                    onTap: () {
                      courseListingVM.changeStatus(status, context);
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
                              "${courseListingVM.statusCountMap[status]}",
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
              child: courseListingVM.coursesListingList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Data.",
                            style: TextStyles.medium2(color: AppColors.black),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: courseListingVM.coursesListingList.length,
                      itemBuilder: (context, index) {
                        final jobData =
                            courseListingVM.coursesListingList[index];
                        final course = jobData;
                        print(courseListingVM.coursesListingList.length);
                        return CouresListingCard(
                          id: course.id ?? "",
                          logoUrl: course.presentedByImage?.url ?? '',
                          companyName: course.courseName ?? '',
                          courseTitle: course.presentedByName ?? '',
                          status: course.status ?? '',
                          description: course.description ?? '',
                          types: [course.type ?? ''],
                          createdAt: course.createdAt ?? '',
                          registeredCount: course.courseRegisteredUsersAggregate
                                  ?.aggregate?.count ??
                              0,
                          onDetailView: () async {
                            /* if (course.status == "DRAFT") {
                              scaffoldMessenger(
                                  "Draft courses cannot be opened");
                              return;
                            }*/

                            await courseListingVM.getCourseDetails(
                              context,
                              course.id ?? "",
                            );

                            navigationService.navigateTo(
                              RouteList.courseDetailScreen,
                            );
                          },
                          onTapRegistered: () async {
                            await courseListingVM.getCourseRegisteredUsers(
                                context, course.id ?? "");
                            final count = course.courseRegisteredUsersAggregate
                                    ?.aggregate?.count ??
                                0;

                            if (count > 0) {
                              navigationService
                                  .navigateTo(RouteList.registeredUsersView);
                            } else {
                              scaffoldMessenger('No Registered Users');
                            }
                          },
                          onMenuAction: (action, id) async {
                            switch (action) {
                              case "Preview":
                                await courseListingVM.getCourseDetails(
                                    context, course.id ?? "");

                                navigationService.navigateTo(
                                  RouteList.courseDetailScreen,
                                );

                                break;
                              case "Edit":
                                await courseListingVM.getCourseDetails(
                                    context, course.id ?? "");
                                newCourseVM.fetchCourseCategory();
                                newCourseVM.fetchCourseType();

                                await loadCourseData(newCourseVM,
                                    courseListingVM.courseDetails.first);

                                navigationService.navigateTo(
                                  RouteList.newCourseScreen,
                                );

                                break;
                              case "Delete":
                                showAlertMessage(context,
                                    'Are you sure you want to delete this course?',
                                    onBack: () {
                                  navigationService.goBack();
                                  courseListingVM.deleteCourse(
                                      context, course.id ?? "");
                                });

                                break;
                              case "Inactive":
                                print("Make course $id inactive");
                                break;
                              case "Active":
                                print("Make course $id active");
                                break;
                            }
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            navigationService.navigateTo(RouteList.newCourseScreen);
            newCourseVM.fetchCourseType();
            newCourseVM.fetchCourseCategory();
          },
          child: SvgPicture.asset(ImageConst.addFeed),
        ));
  }

  Future<void> loadCourseData(
      NewCourseViewModel newCourseVM, CoursesListingDetails course) async {
    // Reset image/file selections
    newCourseVM.serverPresentedImg = course.presentedByImage?.url ?? "";
    newCourseVM.serverCourseHeaderBanner = course.courseBannerVideo?.first.url;
    newCourseVM.serverGallery = course.courseGallery
            ?.map((item) => item.url ?? "")
            .where((url) => url.isNotEmpty)
            .toList() ??
        [];
    newCourseVM.serverCourseBannerImg = course.courseBannerImage
            ?.map((item) => item.url ?? "")
            .where((url) => url.isNotEmpty)
            .toList() ??
        [];
    newCourseVM.serverEventImg = course.courseEventInfo
            ?.map((item) => item.images?.first.url ?? "")
            .where((url) => url.isNotEmpty)
            .toList() ??
        [];
    newCourseVM.serverEventImgs = course.courseEventInfo
            ?.map((item) => item.images?.first.url ?? "")
            .where((url) => url.isNotEmpty)
            .toList() ??
        [];
    newCourseVM.serverSponsoredByImg = course.sponsorByImage
            ?.map((item) => item.url ?? "")
            .where((url) => url.isNotEmpty)
            .toList() ??
        [];
    newCourseVM.serverSessionImg = course.courseEventInfo
            ?.map((item) => item.images?.first.url ?? "")
            .where((url) => url.isNotEmpty)
            .toList() ??
        [];

    // Dropdown / selections
    newCourseVM.selectedCategoryId = course.courseCategoryId;
    newCourseVM.selectedCourseType = course.type;
    newCourseVM.selectedEvent = course.eventType ?? "";

    // Text controllers
    newCourseVM.courseNameController.text = course.courseName ?? "";
    newCourseVM.presenterNameController.text = course.presentedByName ?? "";
    newCourseVM.cpdPointsController.text = course.cpdPoints.toString();
    newCourseVM.numberOfSeatsController.text =
        course.numberOfSeats?.toString() ?? "";
    newCourseVM.totalPriceController.text =
        course.afterwardsPrice?.toStringAsFixed(0) ?? "";
    newCourseVM.birdPriceController.text =
        course.earlyBirdPrice?.toStringAsFixed(0) ?? "";
    newCourseVM.courseDescController.text = course.description ?? "";
    newCourseVM.topicsIncludedDescController.text = course.topicsIncluded ?? "";
    newCourseVM.learningObjectivesDescController.text =
        course.learningObjectives ?? "";
    newCourseVM.nameController.text = course.contactName ?? "";
    newCourseVM.phoneController.text = course.contactPhone ?? "";
    newCourseVM.emailController.text = course.contactEmail ?? "";
    newCourseVM.websiteUrlController.text = course.contactWebsite ?? "";
    newCourseVM.registerLinkController.text = course.registerLink ?? "";
    newCourseVM.termsAndConditionsController.text = course.terms ?? "";
    newCourseVM.cancellationController.text = course.refundPolicy ?? "";
    newCourseVM.rsvpDateController.text = course.rsvpDate ?? "";
    newCourseVM.earlyBirdDateController.text = course.earlyBirdEndDate ?? "";
    newCourseVM.startDateController.text =
        DateFormat("d/M/yyyy").format(DateTime.parse(course.startDate ?? ""));
    newCourseVM.endDateController.text =
        DateFormat("d/M/yyyy").format(DateTime.parse(course.endDate ?? ""));
    newCourseVM.addressController.text = course.address ?? "";
    newCourseVM.startTimeController.text = course.startTime ?? "";
    newCourseVM.endTimeController.text = course.startTime ?? ""; // if same

    // Images / files (from API)
    newCourseVM.presenter_image = course.presentedByImage?.url ?? "";
    newCourseVM.courseBannerImageHeaderList = [];
    newCourseVM.selectedGalleryList = [];
    newCourseVM.courseBannerImgList = [];
    newCourseVM.sponsoredByImgList = [];
    newCourseVM.loadCourseForEdit(course);
  }
}
