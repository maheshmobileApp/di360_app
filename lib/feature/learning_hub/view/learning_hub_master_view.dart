import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/courses_listing_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/learning_hub_master_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LearningHubMasterView extends StatefulWidget {
  const LearningHubMasterView({super.key});

  @override
  State<LearningHubMasterView> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<LearningHubMasterView>
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
          /*title: Stack(
            clipBehavior: Clip.none,
            children: [
              Text(
                'Master Course Listing',
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
          ),*/
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
                  courseListingVM.getAllListingData(context);
                },
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
                        return ListingHubMasterCard(
                          presenterName: course.presentedByName ?? "",
                          profilePic: course.presentedByImage?.url ?? '',
                          imageUrl: course.courseBannerImage?.first.url ?? '',
                          companyName: course.courseName ?? '',
                          description: course.description ?? '',
                          date: course.startDate ?? "",
                          cpdHours: course.cpdPoints?.toStringAsFixed(0)??"0",
                          location: course.address??"",
                          onTap: () async {
                            await courseListingVM.getCourseDetails(
                              context,
                              course.id ?? "",
                            );

                            navigationService.navigateTo(
                              RouteList.courseDetailScreen,
                            );
                          },
                        );
                       
                      },
                    ),
            ),
          ],
        ),
        );
  }
}
