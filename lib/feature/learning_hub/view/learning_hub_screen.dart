import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/courses_listing_card.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
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
            addHorizontal(15),
            SvgPicture.asset(ImageConst.search, color: AppColors.black),
            addHorizontal(15),
          ],
        ),
        body: Column(
          children: [
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
                          companyName: course.presentedByName ?? '',
                          courseTitle: course.companyName ?? '',
                          status: course.status ?? '',
                          description: course.description ?? '',
                          types: [course.type ?? ''],
                          createdAt: course.createdAt ?? '',
                          registeredCount: course.numberOfSeats ?? 0,
                          onDetailView: () async {
                            await courseListingVM.getCourseDetails(
                                context, course.id ?? "");

                            navigationService.navigateTo(
                              RouteList.courseDetailScreen,
                            );
                          },
                          onTapRegistered: () {
                            // Handle navigation or API call
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
                                print("Edit course $id");
                                break;
                              case "Delete":
                                print("Delete course $id");
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
}
