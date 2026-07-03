import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/learning_hub_master_view_model.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view/course_modules_view/course_details_view.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view/learning_hub_view/learning_hub_master_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        Provider.of<MarketPlaceLearningHubViewModel>(context, listen: false)
            .getAllLearningHubData(context, loadMore: true);      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseListingVM =
        Provider.of<MarketPlaceLearningHubViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 248, 248),
      appBar: AppBarWidget(
          searchAction: () =>
              courseListingVM.setSearchBar(!courseListingVM.searchBarOpen),
          filterWidget: Row(
            children: [
              GestureDetector(
                onTap: () => {
                  navigationService
                      .navigateTo(RouteList.learningHubFliterScreen)
                },
                child:
                    SvgPicture.asset(ImageConst.filter, color: AppColors.black),
              ),
              if (courseListingVM.applyFilter)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                      onTap: () {
                        courseListingVM.updateApplyFilter(false);
                        courseListingVM.searchController.clear();
                        Provider.of<LearningHubMasterViewModel>(context,
                                listen: false)
                            .clearFilterOptions();
                        courseListingVM.getAllLearningHubData(context);
                      },
                      child: Icon(Icons.close, color: AppColors.black)),
                )
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (courseListingVM.searchBarOpen)
              SearchWidget(
                controller: courseListingVM.searchController,
                hintText: "Search Course...",
                onClear: () {
                  courseListingVM.searchController.clear();
                  courseListingVM.getAllLearningHubData(context);
                },
                onSearch: () {
                  if (courseListingVM.searchController.text.trim().isNotEmpty) {
                    courseListingVM.getAllLearningHubData(context);
                  } else {
                    scaffoldMessenger("Please enter search text.");
                  }
                },
              ),
            Expanded(
                child: courseListingVM.marketPlaceCoursesList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("No Data.",
                                style:
                                    TextStyles.medium2(color: AppColors.black))
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: courseListingVM
                                .marketPlaceCoursesList.length +
                            (courseListingVM.isLoadingMoreMarketPlace ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index ==
                              courseListingVM.marketPlaceCoursesList.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          final jobData =
                              courseListingVM.marketPlaceCoursesList[index];
                          final course = jobData;
                          final registrationDate =
                              course.courseRegisteredUsers?.isNotEmpty == true
                                  ? course.courseRegisteredUsers?.first
                                      .courseRegisteredDate
                                  : null;
                          final int? durationCount = courseListingVM
                              .getDurationCount(course.courseRegisteredUsers);

                          final remainingDays = (registrationDate != null &&
                                  durationCount != null)
                              ? DateFormatUtils.remainingDays(
                                  registrationDate,
                                  durationCount,
                                )
                              : "Life Time";

                          final isRegistered = courseListingVM
                              .isRegisteredCheck(course.courseRegisteredUsers);

                          return ListingHubMasterCard(
                            feedId: course.id ?? "",
                            afterWardsPrice: course.afterwardsPrice,
                            presenterName: course.presenters?.isNotEmpty == true
                                ? course.presenters?.first.presentedByName ?? ""
                                : "",
                            profilePic: course.presenters?.isNotEmpty == true
                                ? course.presenters?.first.presentedByImage
                                        ?.url ??
                                    ""
                                : "",
                            imageUrl: (course.courseBannerImage!.isNotEmpty)
                                ? course.courseBannerImage?.first.url ?? ''
                                : '',
                            companyName: course.courseName ?? '',
                            description: course.description ?? '',
                            date: course.startDate ?? "",
                            isRegistered: isRegistered,
                            cpdHours: (course.cpdPoints ?? 0) % 1 == 0
                                ? (course.cpdPoints ?? 0).toInt().toString()
                                : (course.cpdPoints ?? 0).toString(),
                            location: course.address != null &&
                                    course.address?.isNotEmpty == true
                                ? (course.address?.first.formattedAddress ??
                                    course.address?.first.city ??
                                    "")
                                : "",
                            expiryDateCount: remainingDays,
                            courseStatus: course
                                .courseRegisteredUsers?.firstOrNull?.status,
                            onTap: () async {
                              await courseListingVM.getCourseDetails(
                                  context, course.id ?? "");
                              await courseListingVM.getProfile();
                              navigationService
                                  .navigateTo(RouteList.courseDetailScreen);
                              /*} else {
                                scaffoldMessenger('Seats are sold out!');
                              }*/
                            },
                            registerTap: // isRegistered ?
                                () async {
                              await courseListingVM.getCourseDetails(
                                  context, course.id ?? "");
                              await courseListingVM.getProfile();
                              if (isRegistered &&
                                  course.courseRegisteredUsers?.firstOrNull
                                          ?.status !=
                                      "EXPIRED" &&
                                  course.type == "Online Academy") {
                                navigationService.push(CourseDetailsView());
                              } else {
                                navigationService
                                    .navigateTo(RouteList.courseDetailScreen);
                              }
                            },
                            // : () {
                            //     // if (seats > 0) {
                            //     courseListingVM
                            //         .setCourseId(course.id ?? "");
                            //     RegistrationUserForm.show(
                            //         context,
                            //         course.courseName ?? "",
                            //         course.createdById ?? "",
                            //         course.id ?? "");
                            //     // } else {
                            //     //   scaffoldMessenger('Seats are sold out!');
                            //     // }
                            //   },
                            type: course.type,
                            noOfSeats: course.numberOfSeats,
                            registerCount: course.courseRegisteredUsersAggregate
                                ?.aggregate?.count,
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
