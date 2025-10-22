import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/header_media_info.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/session_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/courses_listing_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
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
    final courseListingVM = Provider.of<CourseListingViewModel>(context);
    final newCourseVM = Provider.of<NewCourseViewModel>(context);

    var floatingActionButton = FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        newCourseVM.setCurrentStep(0);
        newCourseVM.resetForm();
        newCourseVM.serverImagesClear();
        courseListingVM.setEditOption(false);
        navigationService.navigateTo(RouteList.newCourseScreen);
        newCourseVM.fetchCourseType();
        newCourseVM.fetchCourseCategory();
        newCourseVM.setEditMode(false);
      },
      child: SvgPicture.asset(ImageConst.addFeed),
    );
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBarWidget(
            title: 'Course Listing',
            searchAction: () =>
                courseListingVM.setSearchBar(!courseListingVM.searchBarOpen)),
        body: Column(
          children: [
            if (courseListingVM.searchBarOpen)
              SearchWidget(
                controller: courseListingVM.searchController,
                hintText: "Search Course...",
                onClear: () {
                  courseListingVM.searchController.clear();
                  courseListingVM.getCoursesListingData(context);
                },
                onSearch: () {
                  courseListingVM.getCoursesListingData(context);
                },
              ),
            courseStatusWidget(courseListingVM),
            Divider(),
            coursesListWidget(courseListingVM, newCourseVM),
          ],
        ),
        floatingActionButton: floatingActionButton);
  }

  AppBar appBarWidget(NotificationViewModel notificationVM,
      CourseListingViewModel courseListingVM) {
    return AppBar(
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
                            child: Text('${notificationVM.notificationCount}',
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
            child: SvgPicture.asset(ImageConst.search, color: AppColors.black)),
        addHorizontal(20),
      ],
    );
  }

  Expanded coursesListWidget(
      CourseListingViewModel courseListingVM, NewCourseViewModel newCourseVM) {
    return Expanded(
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
                final jobData = courseListingVM.coursesListingList[index];
                final course = jobData;
                print(courseListingVM.coursesListingList.length);
                return CouresListingCard(
                  id: course.id ?? "",
                  meetingLink: course.meetingLink ?? "",
                  logoUrl: course.presentedByImage?.url ?? '',
                  companyName: course.courseName ?? '',
                  courseTitle: course.presentedByName ?? '',
                  status: course.status ?? '',
                  activeStatus: course.activeStatus ?? "",
                  description: course.description ?? '',
                  types: [course.type ?? ''],
                  createdAt: course.createdAt ?? '',
                  registeredCount:
                      course.courseRegisteredUsersAggregate?.aggregate?.count ??
                          0,
                  onDetailView: () async {
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
                    final count = course
                            .courseRegisteredUsersAggregate?.aggregate?.count ??
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
                        courseListingVM.setEditOption(true);
                        newCourseVM.setCurrentStep(0);
                        courseListingVM.setCourseId(course.id ?? "");

                        newCourseVM.fetchCourseCategory();
                        newCourseVM.fetchCourseType();
                        newCourseVM.setEditMode(true);
                        Loaders.circularShowLoader(context);
                        await loadCourseData(
                            newCourseVM, courseListingVM.courseDetails.first);
                        Loaders.circularHideLoader(context);
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
                        Loaders.circularShowLoader(context);
                        await loadCourseData(
                            newCourseVM, courseListingVM.courseDetails.first);
                        newCourseVM.eraseDateFields();

                        Loaders.circularHideLoader(context);
                        navigationService.navigateTo(
                          RouteList.newCourseScreen,
                        );
                    }
                  },
                );
              },
            ),
    );
  }

  SizedBox courseStatusWidget(CourseListingViewModel courseListingVM) {
    return SizedBox(
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.primaryColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Row(
                children: [
                  Text(
                    status,
                    style: TextStyles.regular2(
                      color:
                          isSelected ? AppColors.whiteColor : AppColors.black,
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${courseListingVM.statusCountMap[status]}",
                      style: TextStyles.regular2(
                        color:
                            isSelected ? AppColors.black : AppColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> loadCourseData(
      NewCourseViewModel newCourseVM, CoursesListingDetails course) async {
    // Reset image/file selections
    newCourseVM.serverPresentedImg = course.presentedByImage?.url ?? "";

    newCourseVM.serverCourseHeaderBanner =
        course.courseBannerVideo != null && course.courseBannerVideo!.isNotEmpty
            ? MediaInfo(
                url: course.courseBannerVideo?.first.url ?? "",
                type: course.courseBannerVideo?.first.type ?? "")
            : null;

    newCourseVM.serverGallery = (course.courseGallery ?? [])
        .map((item) => item.url ?? "")
        .where((url) => url.isNotEmpty)
        .toList();

    newCourseVM.serverCourseBannerImg = (course.courseBannerImage ?? [])
        .map((item) => item.url ?? "")
        .where((url) => url.isNotEmpty)
        .toList();

    newCourseVM.serverEventImg = (course.courseEventInfo ?? [])
        .map((item) =>
            (item.images != null && item.images!.isNotEmpty
                ? item.images!.first.url
                : "") ??
            "")
        .where((url) => url.isNotEmpty)
        .toList();

    newCourseVM.serverSponsoredByImg = (course.sponsorByImage ?? [])
        .map((item) => item.url ?? "")
        .where((url) => url.isNotEmpty)
        .toList();

    newCourseVM.serverSessionImg = (course.courseEventInfo ?? [])
        .map((item) =>
            (item.images != null && item.images!.isNotEmpty
                ? item.images!.first.url
                : "") ??
            "")
        .where((url) => url.isNotEmpty)
        .toList();

    // Dropdown / selections
    newCourseVM.selectedCategoryId = course.courseCategoryId;
    (course.courseCategoryId != null)
        ? await newCourseVM
            .setSelectedCourseCategoryName(course.courseCategoryId)
        : await newCourseVM
            .setSelectedCourseCategoryName("");
    newCourseVM.selectedCourseType = course.type!=null?course.type:"";

    // Text controllers
    newCourseVM.courseNameController.text = course.courseName ?? "";
    newCourseVM.presenterNameController.text = course.presentedByName ?? "";
    newCourseVM.cpdPointsController.text =
        (course.cpdPoints != null) ? course.cpdPoints!.toStringAsFixed(0) : "";
    newCourseVM.numberOfSeatsController.text =
        course.numberOfSeats?.toString() ?? "";
    newCourseVM.totalPriceController.text = (course.afterwardsPrice != null)
        ? course.afterwardsPrice!.toStringAsFixed(0)
        : "";
    newCourseVM.birdPriceController.text = (course.earlyBirdPrice != null)
        ? course.earlyBirdPrice!.toStringAsFixed(0)
        : "";
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
    newCourseVM.earlyBirdDateController.text = course.earlyBirdEndDate ?? "";

    // Dates (safe parse)

    if (course.rsvpDate != null && course.rsvpDate!.isNotEmpty) {
      newCourseVM.rsvpDateController.text =
          DateFormat("d/M/yyyy").format(DateTime.parse(course.rsvpDate!));
    } else {
      newCourseVM.rsvpDateController.text = "";
    }
    if (course.startDate != null && course.startDate!.isNotEmpty) {
      newCourseVM.startDateController.text =
          DateFormat("d/M/yyyy").format(DateTime.parse(course.startDate!));
    } else {
      newCourseVM.startDateController.text = "";
    }

    if (course.endDate != null && course.endDate!.isNotEmpty) {
      newCourseVM.endDateController.text =
          DateFormat("d/M/yyyy").format(DateTime.parse(course.endDate!));
    } else {
      newCourseVM.endDateController.text = "";
    }

    // Address (stringify if it's an object/map)
    if (course.address != null) {
      if (course.address is String) {
        newCourseVM.addressController.text = course.address as String;
      } else if (course.address is Map<String, dynamic>) {
        final addr = course.address as Map<String, dynamic>;
        newCourseVM.addressController.text =
            "${addr['city'] ?? ''}, ${addr['country'] ?? ''}".trim();
      } else {
        newCourseVM.addressController.text = "";
      }
    } else {
      newCourseVM.addressController.text = "";
    }

    String startTime = course.startTime ?? "";
    String endTime = course.endTime ?? "";
    String start_time = startTime.split('+').first;
    String end_time = endTime.split('+').first;

    newCourseVM.startTimeController.text = start_time != ""
        ? DateFormat("h:mm a").format(DateFormat("HH:mm:ss").parse(start_time))
        : "";

    newCourseVM.endTimeController.text = end_time != ""
        ? DateFormat("h:mm a").format(DateFormat("HH:mm:ss").parse(end_time))
        : "";

    // Images / files (from API)
    newCourseVM.presenter_image = course.presentedByImage?.url ?? "";
    newCourseVM.courseBannerImageHeaderList = [];
    newCourseVM.selectedGalleryList = [];
    newCourseVM.courseBannerImgList = [];
    newCourseVM.sponsoredByImgList = [];

    loadCourseForEdit(newCourseVM, course);
  }

  void loadCourseForEdit(
      NewCourseViewModel newCourseVM, CoursesListingDetails course) {
    newCourseVM.selectedEvent = course.eventType == "multiple"
        ? "Multiple Day"
        : "Single Day"; // "Single Day" or "Multiple Day"

    newCourseVM.sessions = course.courseEventInfo?.map((event) {
          return SessionModel(
            sessionName: event.name,
            sessionInfo: event.info,
            eventDate: event.date,
            images: [],
            serverImagesList: event.images, // keep reference to server images
          );
        }).toList() ??
        [];

    if (newCourseVM.sessions.isEmpty) newCourseVM.sessions.add(SessionModel());

    newCourseVM.topicsIncludedDescController.text = course.topicsIncluded ?? "";
    newCourseVM.learningObjectivesDescController.text =
        course.learningObjectives ?? "";
  }
}
