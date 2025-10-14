import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/my_learning_hub/model/filter_section_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/my_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/widgets/filter_section_widget.dart';
import 'package:di360_flutter/feature/my_learning_hub/widgets/register_course_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MyLearningHubScreen extends StatefulWidget {
  const MyLearningHubScreen({super.key});

  @override
  State<MyLearningHubScreen> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<MyLearningHubScreen>
    with BaseContextHelpers {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myLearningHubVM = Provider.of<MyLearningHubViewModel>(context);
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
                'My Learning Hub',
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
                  myLearningHubVM.setSearchBar(!myLearningHubVM.searchBarOpen);
                },
                child: SvgPicture.asset(ImageConst.search,
                    color: AppColors.black)),
            addHorizontal(15),
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
                      myLearningHubVM.getCoursesWithFilters(
                          context, type, category);
                    },
                    onClear: () {
                      navigationService.goBack();
                    },
                    
                  ),
                )
              },
              child:
                  SvgPicture.asset(ImageConst.filter, color: AppColors.black),
            ),
            addHorizontal(15),
          ],
        ),
        body: Column(
          children: [
            Divider(),
            if (myLearningHubVM.searchBarOpen)
              SearchWidget(
                controller: myLearningHubVM.searchController,
                hintText: "Search Course...",
                onClear: () {
                  myLearningHubVM.searchController.clear();
                  myLearningHubVM.getCoursesWithMyRegistrations(context);
                },
                onSearch: () {
                  myLearningHubVM.getCoursesWithMyRegistrations(context);
                },
                
              ),
            Expanded(
              child: myLearningHubVM.myRegisteredCourses.isEmpty
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
                      itemCount: myLearningHubVM.myRegisteredCourses.length,
                      itemBuilder: (context, index) {
                        final courseData =
                            myLearningHubVM.myRegisteredCourses[index];
                        return RegisterCourseCard(
                          logo: courseData.presentedByImage?.url ?? "",
                          cpdPoints: courseData.cpdPoints.toString(),
                          courseName: courseData.courseName ?? "",
                          name: courseData.presentedByName ?? "",
                          status: courseData.status ?? "",
                          types: courseData.type ?? "",
                          link: courseData.webinarLink ?? "",
                          onCardTap: () async {
                            await courseListingVM.getCourseDetails(
                                context, courseData.id ?? "");

                            navigationService.navigateTo(
                              RouteList.courseDetailScreen,
                            );
                          },
                          createdAt: courseData.createdAt ?? "",
                        );
                      },
                    ),
            ),
          ],
        ));
  }
}
