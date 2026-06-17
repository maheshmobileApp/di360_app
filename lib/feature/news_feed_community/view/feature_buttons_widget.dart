import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeatureButtonsWidget extends StatelessWidget {
  final String? communityMemberDirectorId;
  const FeatureButtonsWidget({super.key, this.communityMemberDirectorId});

  @override
  Widget build(BuildContext context) {
    final directoryVM = Provider.of<DirectoryViewModel>(context);
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ConstantData.featureStatus.length,
        itemBuilder: (context, index) {
          String status = ConstantData.featureStatus[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8, left: 2),
            child: AppButton(
                btnColor: AppColors.whiteColor,
                btnTextColor: AppColors.black,
                text: status,
                height: 45,
                width: 130,
                radius: 8,
                onTap: () async {
                  if (index == 0 || index == 1 || index == 2) {
                    Loaders.circularShowLoader(context);
                    await directoryVM.GetDirectorDetails(
                        communityMemberDirectorId ?? '');
                    Loaders.circularHideLoader(context);
                    final scrollTo = index == 1
                        ? 'Partner'
                        : index == 2
                            ? 'Contact Us'
                            : null;
                    await navigationService.navigateToWithParams(
                        RouteList.directoryDetailsScreen,
                        params: scrollTo);
                  } else if (index == 3) {
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
                    await navigationService
                        .navigateTo(RouteList.learningHubMasterView);
                  } else if (index == 4) {
                    navigationService.goBack();
                    await Future.delayed(const Duration(milliseconds: 100));
                    final ctx = navigatorKey.currentContext!;
                    ctx
                        .read<DashBoardViewModel>()
                        .setIndex(4, ctx, isCommunityCatalogue: true);
                  }
                }),
          );
        },
      ),
    );
  }
}
