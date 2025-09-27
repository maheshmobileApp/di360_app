import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/account/account_model/account_model.dart';
import 'package:di360_flutter/feature/account/account_view_model/account_view_model.dart';
import 'package:di360_flutter/feature/account/repository/account_repo_impl.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/banners/view_model/banners_view_model.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/my_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget with BaseContextHelpers {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    return ChangeNotifierProvider(
      create: (_) =>
          ProfileViewModel(ProfileRepositoryImpl())..fetchProfileSections(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: _buildAppBar(),
        body: Consumer<ProfileViewModel>(
          builder: (context, vm, _) {
            if (vm.error != null) {
              return Center(
                child: Text(
                  'Error: ${vm.error}',
                  style: TextStyles.regular3(color: AppColors.redColor),
                ),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildProfileHeader(),
                addVertical(16),
                ...vm.visibleSections
                    .map((section) =>
                        _buildSection(context, section, addDirectorVM))
                    .toList(),
                addVertical(12),
                _buildLogoutTile(context),
              ],
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          addHorizontal(16),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Text(
                'Dental Interface',
                style: TextStyles.semiBold(
                  color: AppColors.black,
                  fontSize: 16,
                ),
              ),
              Positioned(
                top: -6,
                right: -20,
                child: SvgPicture.asset(
                  ImageConst.logo,
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: const [
        Icon(Icons.notifications_none, color: AppColors.black),
        SizedBox(width: 10),
        Icon(Icons.search, color: AppColors.black),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        addVertical(20),
        CircleAvatar(
          radius: 42,
          backgroundColor: AppColors.geryColor.withOpacity(0.2),
          child: SvgPicture.asset(
            ImageConst.accountProfile,
            width: 50,
            height: 50,
          ),
        ),
        addVertical(8),
        Text(
          "Profile Name",
          style: TextStyles.medium3(color: AppColors.black, fontSize: 15),
        ),
        Text(
          "Job Designation",
          style: TextStyles.regular1(
            color: AppColors.bottomNavUnSelectedColor,
            fontSize: 12,
          ),
        ),
        addVertical(12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.timeBgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "200",
                    style: TextStyles.bold3(color: AppColors.black),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Followers",
                    style: TextStyles.regular2(color: AppColors.primaryColor),
                  ),
                ],
              ),
              Container(width: 1, height: 20, color: AppColors.geryColor),
              Row(
                children: [
                  Text(
                    "150",
                    style: TextStyles.bold3(color: AppColors.black),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Following",
                    style: TextStyles.regular2(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, ProfileCategory section, AddDirectoryViewModel vm) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 247, 249, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              section.title,
              style: TextStyles.medium3(color: AppColors.black, fontSize: 15),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: List.generate(
                section.subTitle.length,
                (index) {
                  final item = section.subTitle[index];
                  final isLast = index == section.subTitle.length - 1;
                  return Column(
                    children: [
                      ListTile(
                        leading: SvgPicture.asset(
                          item.asset,
                          width: 22,
                          height: 22,
                          placeholderBuilder: (context) => const SizedBox(
                            width: 22,
                            height: 22,
                          ),
                        ),
                        title: Text(
                          item.title,
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                        onTap: () async {
                          final userId = await LocalStorage.getStringVal(
                              LocalStorageConst.userId);

                          if (item.title == 'Catalogues') {
                            await context
                                .read<AddCatalogueViewModel>()
                                .getMyCataloguesData(
                                    navigatorKey.currentContext!);
                            await navigationService
                                .navigateTo(RouteList.myCatalogueScreen);
                          } else if (item.title == 'Job Listings') {
                            Loaders.circularShowLoader(context);
                            await context
                                .read<JobListingsViewModel>()
                                .getMyJobListingData();
                            Loaders.circularHideLoader(context);

                            navigationService
                                .navigateTo(RouteList.JobListingScreen);
                          } else if (item.title == 'JobProfile') {
                            navigationService
                                .navigateTo(RouteList.JobProfileScreen);
                          } else if (item.title == 'Applied Jobs') {
                            Navigator.pushNamed(
                              context,
                              RouteList.AppliedJobScreen,
                              arguments: userId,
                            );
                          } else if (item.title == 'Enquiries') {
                            Navigator.pushNamed(
                              context,
                              RouteList.EnquiriesScreen,
                              arguments: userId,
                            );
                          } else if (item.title == 'Talent Request') {
                            Loaders.circularShowLoader(context);
                            await context
                                .read<TalentListingViewModel>()
                                .getMyTalentListingData();
                            Loaders.circularHideLoader(context);

                            navigationService
                                .navigateTo(RouteList.TalentListingScreen);
                          } else if (item.title == 'My Directory') {
                            context
                                .read<AddDirectoryViewModel>()
                                .fetchTheDirectorData(context);
                          } else if (item.title == 'Learning Hub') {
                            Loaders.circularShowLoader(context);
                            await context
                                .read<CourseListingViewModel>()
                                .getCoursesListingData(context, "");
                            Loaders.circularHideLoader(context);
                            context
                                .read<CourseListingViewModel>()
                                .searchBarOpen = false;
                            context
                                .read<CourseListingViewModel>()
                                .searchController
                                .text = "";
                            navigationService
                                .navigateTo(RouteList.learningHubScreen);
                          } else if (item.title == 'My Learning Hub') {
                            Loaders.circularShowLoader(context);
                            await context
                                .read<MyLearningHubViewModel>()
                                .getCoursesWithMyRegistrations(context);
                            Loaders.circularHideLoader(context);
                            context
                                .read<MyLearningHubViewModel>()
                                .searchBarOpen = false;
                            context
                                .read<MyLearningHubViewModel>()
                                .searchController
                                .text = "";
                            context
                                .read<NewCourseViewModel>()
                                .fetchCourseCategory();
                            context
                                .read<NewCourseViewModel>()
                                .fetchCourseType();
                            navigationService
                                .navigateTo(RouteList.myLearningHubScreen);
                          } else if (item.title == "Banners") {
                            Loaders.circularShowLoader(context);
                            await context
                                .read<BannersViewModel>()
                                .getBannersList();

                            Loaders.circularHideLoader(context);
                            navigationService
                                .navigateTo(RouteList.bannersListView);
                          }
                        },
                      ),
                      if (!isLast)
                        Divider(height: 1, color: AppColors.dividerColor),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () => logOutAlert(context),
        child: Row(
          children: [
            SvgPicture.asset(
              ImageConst.logout,
              width: 20,
              height: 20,
            ),
            addHorizontal(10),
            Text(
              "Logout",
              style: TextStyles.medium2(
                color: AppColors.PRIMARY_BLACK_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
