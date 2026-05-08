import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view/course_modules_view/course_details_view.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/filter_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/my_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/widgets/filter_section_widget.dart';
import 'package:di360_flutter/feature/my_learning_hub/widgets/register_course_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final myLearningHubVM =
          Provider.of<MyLearningHubViewModel>(context, listen: false);
      myLearningHubVM.getCoursesWithMyRegistrations(context, loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myLearningHubVM = Provider.of<MyLearningHubViewModel>(context);
    final courseListingVM = Provider.of<CourseListingViewModel>(context);
    final filterVM = Provider.of<FilterViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBarWidget(
            logo: false,
            title: 'My Learning Hub',
            searchAction: () =>
                myLearningHubVM.setSearchBar(!myLearningHubVM.searchBarOpen),
            filterWidget: GestureDetector(
                onTap: () {
                  filterVM.fetchCourseCategory(context);
                  filterVM.fetchCourseType(context);

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => FilterBottomSheet(
                      onApply: () {
                        myLearningHubVM.getCoursesWithMyRegistrations(
                            context,
                            type : filterVM.selectedOptions['Filter by Type'],
                            category: filterVM.selectedOptions['Category'],
                            date: filterVM.selectedDate.toString());
                        navigationService.goBack();
                      },
                      onClear: () {
                        filterVM.clearAll();
                        myLearningHubVM.getCoursesWithMyRegistrations(
                            context,
                            type: filterVM.selectedOptions['Filter by Type'],
                            category: filterVM.selectedOptions['Category'],
                            date: filterVM.selectedDate.toString());
                      },
                    ),
                  );
                },
                child: SvgPicture.asset(ImageConst.filter,
                    color: AppColors.black))),
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
              child: myLearningHubVM.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor))
                  : myLearningHubVM.myRegisteredCourses.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Data.",
                                style:
                                    TextStyles.medium2(color: AppColors.black),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              myLearningHubVM.myRegisteredCourses.length +
                                  (myLearningHubVM.isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index ==
                                myLearningHubVM.myRegisteredCourses.length) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(
                                      color: AppColors.primaryColor),
                                ),
                              );
                            }

                            final courseData =
                                myLearningHubVM.myRegisteredCourses[index];
                            return RegisterCourseCard(
                              courseData: courseData,
                              onViewCourseTap: () async{
                                await courseListingVM.getCourseDetails(
                                    context, courseData.id ?? "");
                                navigationService.push(CourseDetailsView());
                              },
                              onCardTap: () async {
                                await courseListingVM.getCourseDetails(
                                    context, courseData.id ?? "");

                                navigationService.navigateTo(
                                  RouteList.courseDetailScreen,
                                );
                              },
                            );
                          },
                        ),
            ),
          ],
        ));
  }
}
