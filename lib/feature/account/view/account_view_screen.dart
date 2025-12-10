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
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/enquiries/view_model/enquiries_view_model.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/filter_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/my_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/notifaction_panel.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/feature/support/view_model/support_view_model.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget with BaseContextHelpers {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final profileVM = Provider.of<ProfileViewModel>(context);
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(ProfileRepositoryImpl())
        ..fetchProfileSections(profileVM.communityStatus),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        endDrawer: NotificationsPanel(),
        appBar: AppBarWidget(searchWidget: false),
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
                _buildProfileHeader(homeViewModel),
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

  Widget _buildProfileHeader(HomeViewModel vm) {
    return Column(children: [
      addVertical(20),
      CircleAvatar(
          backgroundColor: AppColors.whiteColor,
          radius: 52,
          child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: 50,
              child: ClipOval(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CachedNetworkImageWidget(
                          imageUrl: vm.profilePic ?? '',
                          fit: BoxFit.fill,
                          errorWidget: Image.asset(ImageConst.prfImg)))))),
      addVertical(8),
      Text(vm.userName ?? "Profile Name",
          style: TextStyles.medium3(color: AppColors.black, fontSize: 15)),
      Text(vm.userType ?? "Job Designation",
          style:
              TextStyles.regular1(color: AppColors.bottomNavUnSelectedColor)),
      addVertical(12)
    ]);
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
                            await navigationService
                                .navigateTo(RouteList.myCatalogueScreen);
                          } else if (item.title == 'View Profile') {
                            Loaders.circularShowLoader(context);
                            final type = await LocalStorage.getStringVal(
                                LocalStorageConst.type);
                            await context
                                .read<ViewProfileViewModel>()
                                .getBusinessTypes();
                            await context
                                .read<ViewProfileViewModel>()
                                .getTheViewProfileData();
                            Loaders.circularHideLoader(context);
                            type == 'PROFESSIONAL'
                                ? await navigationService.navigateTo(
                                    RouteList.professionalViewProfileScreen)
                                : await navigationService
                                    .navigateTo(RouteList.viewProfileScreen);
                          } else if (item.title == 'Job Listings') {
                            Loaders.circularShowLoader(context);
                            await context
                                .read<JobListingsViewModel>()
                                .getMyJobListingData(context);
                            Loaders.circularHideLoader(context);
                            navigationService
                                .navigateTo(RouteList.JobListingScreen);
                          } else if (item.title == 'JobProfile') {
                            Loaders.circularShowLoader(context);
                            await context
                                .read<JobProfileListingViewModel>()
                                .fetchJobProfiles(context);
                            Loaders.circularHideLoader(context);
                            navigationService
                                .navigateTo(RouteList.JobProfileScreen);
                          } else if (item.title == 'Applied Jobs') {
                            Navigator.pushNamed(
                              context,
                              RouteList.AppliedJobScreen,
                              arguments: userId,
                            );
                          } else if (item.title == 'Enquiries') {
                            Loaders.circularShowLoader(context);
                            await context
                                .read<EnquiriesViewModel>()
                                .getMyEnquiryJobData(context);
                            Loaders.circularHideLoader(context);

                            Navigator.pushNamed(
                              context,
                              RouteList.EnquiriesScreen,
                              arguments: userId,
                            );
                          } else if (item.title == 'Talent Listing') {
                            Loaders.circularShowLoader(context);
                            await context
                                .read<TalentListingViewModel>()
                                .getMyTalentListingData();
                            Loaders.circularHideLoader(context);

                            navigationService
                                .navigateTo(RouteList.TalentListingScreen);
                          } else if (item.title == 'My Directory') {
                            await context
                                .read<AddDirectoryViewModel>()
                                .fetchTheDirectorData(
                                    navigatorKey.currentContext!);
                          } else if (item.title == 'Learning Hub') {
                            Loaders.circularShowLoader(context);
                            await context
                                .read<CourseListingViewModel>()
                                .getCoursesListingData(context);
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
                            await context
                                .read<FilterViewModel>()
                                .fetchCourseCategory(context);
                            await context
                                .read<FilterViewModel>()
                                .fetchCourseType(context);

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
                            navigationService
                                .navigateTo(RouteList.bannersListView);
                          } else if (item.title == "Appointments") {
                            navigationService
                                .navigateTo(RouteList.myAppointment);
                          } else if (item.title == "Support Request") {
                          
                            navigationService
                                .navigateTo(RouteList.supportScreen);
                          } else if (item.title == "Join Request") {
                            navigationService
                                .navigateTo(RouteList.joinRequestView);
                          } else if (item.title == "Partnership Request") {
                            navigationService
                                .navigateTo(RouteList.partnershipRequestView);
                          } else if (item.title == "Membership Registration") {
                            navigationService.navigateTo(
                                RouteList.membershipRegistrationView);
                          } else if (item.title == "Partnership Registration") {
                            navigationService.navigateTo(
                                RouteList.partnershipRegistrationView);
                          } else if (item.title == "News Feed Categories") {
                            navigationService
                                .navigateTo(RouteList.newsFeedCategoriesView);
                          } else if (item.title == "News Feed") {
                             context
                                .read<DashBoardViewModel>()
                                .setIndex(1,context);
                          }  
                          else if (item.title.contains("Community")) {
                            final viewModel = Provider.of<CommunityViewModel>(
                                context,
                                listen: false);
                            final newsFeedVM =
                                Provider.of<NewsFeedCommunityViewModel>(context,
                                    listen: false);
                            await viewModel.getNewsFeedCategories(context);
                            newsFeedVM.newsFeedCategoriesData =
                                viewModel.newsFeedCategoriesData;

                            newsFeedVM.newsFeedCategory = viewModel
                                    .newsFeedCategoriesData?.newsfeedCategories
                                    ?.map((e) => e.categoryName ?? "")
                                    .toList() ??
                                [];
                            navigationService
                                .navigateTo(RouteList.newsFeedCommunityView);
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
