import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GridWidget extends StatelessWidget with BaseContextHelpers {
  const GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoardVM = Provider.of<DashBoardViewModel>(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ConstantData.homeGridImgs.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 4.4 / 3),
      itemBuilder: (context, index) {
        final img = ConstantData.homeGridImgs[index];
        final title = ConstantData.homeGridTitles[index];
        return GestureDetector(
          onTap: () {
            gridOnTap(title, context, dashBoardVM);
          },
          child: Column(
            children: [
              SvgPicture.asset(img),
              addVertical(10),
              Text(title, style: TextStyles.regular2(color: AppColors.black))
            ],
          ),
        );
      },
    );
  }

  gridOnTap(String title, BuildContext context,
      DashBoardViewModel dashBoardVM) async {
    if (title == 'News Feed') {
      dashBoardVM.setIndex(1, navigatorKey.currentContext!);
    } else if (title == 'Job Seek') {
      dashBoardVM.setIndex(2, navigatorKey.currentContext!);
    } else if (title == 'Catalogue') {
      dashBoardVM.setIndex(3, navigatorKey.currentContext!);
    } else if (title == 'Directory') {
      await context.read<DirectoryViewModel>().getDirectorsList(context);
      await navigationService.navigateTo(RouteList.directory);
    } else if (title == 'Learning Hub') {
      Loaders.circularShowLoader(context);
      context.read<CourseListingViewModel>().searchBarOpen = false;
      context.read<CourseListingViewModel>().searchController.text = "";
      await context.read<CourseListingViewModel>().getAllListingData(context);
      Loaders.circularHideLoader(context);
      await navigationService.navigateTo(RouteList.learningHubMasterView);
    }
  }
}
