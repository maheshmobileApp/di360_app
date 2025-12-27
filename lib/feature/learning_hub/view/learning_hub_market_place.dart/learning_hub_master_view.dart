import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view/registration_user_form.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/learning_hub_master_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/learning_hub_master_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/news_feed/view/notifaction_panel.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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
    final viewModel =
        Provider.of<LearningHubMasterViewModel>(context, listen: false);
    viewModel.clearFilterOptions();
  }

  @override
  Widget build(BuildContext context) {
    final courseListingVM = Provider.of<CourseListingViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 248, 248),
      endDrawer: NotificationsPanel(),
      appBar: AppBarWidget(
          searchAction: () =>
              courseListingVM.setSearchBar(!courseListingVM.searchBarOpen),
          filterWidget: GestureDetector(
            onTap: () => {
              navigationService.navigateTo(RouteList.learningHubFliterScreen)
            },
            child: SvgPicture.asset(ImageConst.filter, color: AppColors.black),
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
                  courseListingVM.getAllListingData(context);
                },
                onSearch: () {
                  courseListingVM.getAllListingData(context);
                },
              ),
            Expanded(
                child: courseListingVM.marketPlaceCoursesList.isEmpty
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
                        itemCount:
                            courseListingVM.marketPlaceCoursesList.length,
                        itemBuilder: (context, index) {
                          final jobData =
                              courseListingVM.marketPlaceCoursesList[index];
                          final course = jobData;

                          final seats = (course.numberOfSeats -
                              course.courseRegisteredUsersAggregate?.aggregate
                                  ?.count);

                          return ListingHubMasterCard(
                            remainingOfSeats: seats,
                            presenterName: course.presentedByName ?? "",
                            profilePic: course.presentedByImage?.url ?? '',
                            imageUrl: (course.courseBannerImage!.isNotEmpty)
                                ? course.courseBannerImage?.first.url ?? ''
                                : '',
                            companyName: course.courseName ?? '',
                            description: course.description ?? '',
                            date: course.startDate ?? "",
                            cpdHours:
                                course.cpdPoints?.toStringAsFixed(0) ?? "0",
                            location: course.address ?? "",
                            onTap: () async {
                              if (seats > 0) {
                                await courseListingVM.getCourseDetails(
                                  context,
                                  course.id ?? "",
                                );

                                await courseListingVM.getCourseRegisteredUsers(
                                    context, course.id ?? "");

                                await courseListingVM.registerCourseHandler(
                                    context, course.createdById ?? "");
                                navigationService.navigateTo(
                                  RouteList.courseDetailScreen,
                                );
                              } else {
                                scaffoldMessenger('Seats are sold out!');
                              }
                            },
                            registerTap: () async {
                              if (seats > 0) {
                                courseListingVM.setCourseId(course.id ?? "");
                                RegistrationUserForm.show(
                                    context,
                                    course.courseName ?? "",
                                    course.createdById ?? "");
                              } else {
                                scaffoldMessenger('Seats are sold out!');
                              }
                            },
                            onShareTap: () {
                              SharePlus.instance.share(ShareParams(
                                  uri: Uri.parse(
                                      'https://api.dentalinterface.com/api/v1/prelogin/9dab6d94-589e-46f7-ab39-9156d62afa7b')));
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
