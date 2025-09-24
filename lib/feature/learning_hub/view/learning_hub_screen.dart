import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/courses_listing_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                                addData(newCourseVM, course);

                                navigationService.navigateTo(
                                  RouteList.newCourseScreen,
                                );

                                break;
                              case "Delete":
                                courseListingVM.deleteCourse(
                                    context, course.id ?? "");

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

  void addData(NewCourseViewModel viewModel, CoursesListingDetails course) {
    // Reset image/file selections (optional, keep null until user picks new ones)
    viewModel.selectedPresentedImg = null;
    viewModel.selectedCourseHeaderBanner = null;
    viewModel.selectedGallery = null;
    viewModel.selectedCourseBannerImg = null;
    viewModel.selectedEventImg = null;
    viewModel.selectedsponsoredByImg = null;

    // Dropdown / selections
    viewModel.selectedCategoryId = course.courseCategoryId;
    viewModel.selectedCourseType = course.type;
    viewModel.selectedEvent = course.eventType ?? "";

    // Text controllers
    viewModel.courseNameController.text = course.courseName ?? "";
    viewModel.presenterNameController.text = course.presentedByName ?? "";
    viewModel.cpdPointsController.text = course.cpdPoints?.toString() ?? "0";
    viewModel.numberOfSeatsController.text =
        course.numberOfSeats?.toString() ?? "";
    viewModel.totalPriceController.text =
        course.afterwardsPrice?.toString() ?? "";
    viewModel.birdPriceController.text =
        course.earlyBirdPrice?.toString() ?? "";
    viewModel.courseDescController.text = course.description ?? "";
    viewModel.topicsIncludedDescController.text = course.topicsIncluded ?? "";
    viewModel.learningObjectivesDescController.text =
        course.learningObjectives ?? "";
    viewModel.nameController.text = course.contactName ?? "";
    viewModel.phoneController.text = course.contactPhone ?? "";
    viewModel.emailController.text = course.contactEmail ?? "";
    viewModel.websiteController.text = course.contactWebsite ?? "";
    viewModel.registerLinkController.text = course.registerLink ?? "";
    viewModel.termsAndConditionsController.text = course.terms ?? "";
    viewModel.cancellationController.text = course.refundPolicy ?? "";
    viewModel.rsvpDateController.text = course.rsvpDate ?? "";
    viewModel.earlyBirdDateController.text = course.earlyBirdEndDate ?? "";
    viewModel.startDateController.text = course.startDate ?? "";
    viewModel.endDateController.text = course.endDate ?? "";
    viewModel.addressController.text = course.address ?? "";
    viewModel.startTimeController.text = course.startTime ?? "";
    viewModel.endTimeController.text = course.startTime ?? ""; // if same

    // Images / files (from API)
    viewModel.presenter_image = course.presentedByImage?.url ?? "";
    viewModel.courseBannerImageHeaderList = [];
    viewModel.selectedGalleryList =[];
    viewModel.courseBannerImgList =[];
    viewModel.sponsoredByImgList = [];

    // Sessions / Course Event Info
    viewModel.courseInfoList = [];
    viewModel.sessions = [];
  }
}
