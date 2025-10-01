import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view/registration_user_form.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/learning_hub_master_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/my_learning_hub/model/filter_section_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/widgets/filter_section_widget.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
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
      backgroundColor: const Color.fromARGB(255, 249, 248, 248),
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Stack(
          clipBehavior: Clip.none,
          children: [
            Text(
              'Dental Interface',
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
          addHorizontal(15),
          GestureDetector(
              onTap: () {
                courseListingVM.setSearchBar(!courseListingVM.searchBarOpen);
              },
              child:
                  SvgPicture.asset(ImageConst.search, color: AppColors.black)),
          addHorizontal(20),
          GestureDetector(
            onTap: () => {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => FilterBottomSheet(
                  sections: [
                    FilterSectionModel(
                      title: "Filter by Type",
                      options: newCourseVM.courseTypeNames,
                    ),
                    FilterSectionModel(
                      title: "Category",
                      options: newCourseVM.courseCategory,
                    ),
                  ],
                  onApply: (selectedOptions) {
                    final type = selectedOptions["Filter by Type"];
                    final category = selectedOptions["Category"];
                    final date = selectedOptions["Filter by Date"];
                    final location = selectedOptions["Filter by Location"];
                    courseListingVM.setSelectedCourseCategory(category);
                    courseListingVM.getMarketPlaceCoursesWithFilters(
                        context,
                        type ?? "",
                        courseListingVM.selectedCategoryId ?? "",
                        date ?? "",
                        location ?? "");
                  },
                  onClear: () {
                    courseListingVM.getMarketPlaceCoursesWithFilters(
                        context, "", "", "", "");
                    navigationService.goBack();
                  },
                ),
              )
            },
            child: SvgPicture.asset(ImageConst.filter, color: AppColors.black),
          ),
          addHorizontal(15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                        physics: const BouncingScrollPhysics(),
                        itemCount: courseListingVM.coursesListingList.length,
                        itemBuilder: (context, index) {
                          final jobData =
                              courseListingVM.coursesListingList[index];
                          final course = jobData;

                          return ListingHubMasterCard(
                            presenterName: course.presentedByName ?? "",
                            profilePic: course.presentedByImage?.url ?? '',
                            imageUrl: course.courseBannerImage?.first.url ?? '',
                            companyName: course.courseName ?? '',
                            description: course.description ?? '',
                            date: course.startDate ?? "",
                            cpdHours:
                                course.cpdPoints?.toStringAsFixed(0) ?? "0",
                            location: course.address ?? "",
                            onTap: () async {
                              await courseListingVM.getCourseDetails(
                                context,
                                course.id ?? "",
                              );
                              navigationService.navigateTo(
                                RouteList.courseDetailScreen,
                              );
                            },
                            registerTap: () async {
                              courseListingVM.setCourseId(course.id ?? "");
                              RegistrationUserForm.show(
                                  context, course.courseName ?? "");
                            },
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
