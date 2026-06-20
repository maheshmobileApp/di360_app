import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeatureButtonsWidget extends StatelessWidget {
  final String? communityMemberDirectorId;
  const FeatureButtonsWidget({super.key, this.communityMemberDirectorId});

  @override
  Widget build(BuildContext context) {
    final directoryVM = Provider.of<DirectoryViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ConstantData.featureStatus.length,
          itemBuilder: (context, index) {
            String status = ConstantData.featureStatus[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () async {
                  if (index == 0 || index == 1 || index == 2) {
                    Loaders.circularShowLoader(context);
                    await directoryVM.GetDirectorDetails(
                        communityMemberDirectorId ?? '');
                    await directoryVM
                        .getDirectory(communityMemberDirectorId ?? "");
                    final scrollTo = index == 1
                        ? 'Partner'
                        : index == 2
                            ? 'Contact Us'
                            : null;
                    if (index == 1) {
                      if (directoryVM
                              .directorDetails?.directoryPartners?.isEmpty ??
                          false) {
                        scaffoldMessenger("No Partners Available");
                      } else {
                        navigationService.navigateToWithParams(
                            RouteList.directoryDetailsScreen,
                            params: scrollTo);
                      }
                    } else if (index == 2) {
                      final noEmail = (directoryVM
                                  .directorDetails?.businessEmail?.isNotEmpty ??
                              false) ==
                          false;

                      final noMobile = (directoryVM
                                  .directorDetails?.mobileNumber?.isNotEmpty ??
                              false) ==
                          false;

                      if (noEmail && noMobile) {
                        scaffoldMessenger("No Contacts Available");
                      } else {
                        navigationService.navigateToWithParams(
                          RouteList.directoryDetailsScreen,
                          params: scrollTo,
                        );
                      }
                    } else {
                      navigationService.navigateToWithParams(
                          RouteList.directoryDetailsScreen,
                          params: scrollTo);
                    }

                    Loaders.circularHideLoader(context);
                  } else if (index == 3) {
                    navigationService
                        .navigateTo(RouteList.learningHubMasterView);
                    Loaders.circularShowLoader(context);
                    context
                        .read<MarketPlaceLearningHubViewModel>()
                        .searchBarOpen = false;
                    context
                        .read<MarketPlaceLearningHubViewModel>()
                        .searchController
                        .text = "";
                    context.read<NewCourseViewModel>().fetchCourseCategory();
                    context.read<NewCourseViewModel>().fetchCourseType();
                    await context
                        .read<MarketPlaceLearningHubViewModel>()
                        .getAllLearningHubData(context,
                            isCommunityLearningHub: true);
                    Loaders.circularHideLoader(context);
                  } else if (index == 4) {
                    navigationService.navigateTo(RouteList.catalogueScreen);
                    context
                        .read<CatalogueViewModel>()
                        .fetchCatalogue(context, isCommunityCatalogue: true);
                  }
                },
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: AppColors.primaryColor, width: 1)),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(status,
                        style: TextStyles.medium3(color: AppColors.black)),
                  )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
