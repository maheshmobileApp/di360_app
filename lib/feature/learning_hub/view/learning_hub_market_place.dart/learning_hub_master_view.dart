import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/learning_hub/view/registration_user_form.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/learning_hub_master_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/learning_hub_master_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel =
          Provider.of<LearningHubMasterViewModel>(context, listen: false);

      viewModel.clearFilterOptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseListingVM = Provider.of<CourseListingViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 248, 248),
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

                          final seats = (course.numberOfSeats ?? 0) -
                              (course.courseRegisteredUsersAggregate?.aggregate
                                      ?.count ??
                                  0);
                          final isRegistered = courseListingVM
                              .isRegisteredCheck(course.courseRegisteredUsers);

                          return ListingHubMasterCard(
                            feedId: course.id ?? "",
                            remainingOfSeats: seats,
                            presenterName: course.presenters?.isNotEmpty == true
                                ? course.presenters?.first.presentedByName ?? ""
                                : "",
                            profilePic: course.presentedByImage?.url ?? '',
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
                            registerTap: isRegistered
                                ? () {
                                    scaffoldMessenger("Already Registered!");
                                  }
                                : () async {
                                    if (seats > 0) {
                                      courseListingVM
                                          .setCourseId(course.id ?? "");
                                      RegistrationUserForm.show(
                                          context,
                                          course.courseName ?? "",
                                          course.createdById ?? "",
                                          course.id ?? "");
                                    } else {
                                      scaffoldMessenger('Seats are sold out!');
                                    }
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
