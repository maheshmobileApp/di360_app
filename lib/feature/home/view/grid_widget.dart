import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/dash_board/home_grid_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GridWidget extends StatelessWidget with BaseContextHelpers {
  final List<HomeGridItem> visibleItems;
  const GridWidget({super.key, required this.visibleItems});

  @override
  Widget build(BuildContext context) {
    final dashBoardVM = Provider.of<DashBoardViewModel>(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: dashBoardVM.userType == UserRole.admin.value
          ? ConstantData.adminHomeGridImgs.length
          : visibleItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20, crossAxisCount: 3, childAspectRatio: 4.4 / 3),
      itemBuilder: (context, index) {
        final item = visibleItems[index];
        final img = dashBoardVM.userType == UserRole.admin.value
            ? ConstantData.adminHomeGridImgs[index]
            : item.image;
        final title = dashBoardVM.userType == UserRole.admin.value
            ? ConstantData.adminHomeGridTitles[index]
            : item.title;
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
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (title == 'News Feed') {
      dashBoardVM.setIndex(1, navigatorKey.currentContext!);
    } else if (title == 'Job Seek') {
      dashBoardVM.setIndex(2, navigatorKey.currentContext!);
    } else if (title == 'Catalogue') {
      dashBoardVM.setIndex(type == UserRole.practice.value ? 3 : 4,
          navigatorKey.currentContext!);
    } else if (title == 'Support') {
      navigationService.navigateTo(RouteList.supportScreen);
    } else if (title == 'Directory') {
      await navigationService.navigateTo(RouteList.directory);
    } else if (title == 'Learning Hub') {
      Loaders.circularShowLoader(context);
      context.read<MarketPlaceLearningHubViewModel>().searchBarOpen = false;
      context.read<MarketPlaceLearningHubViewModel>().searchController.text =
          "";
      context.read<NewCourseViewModel>().fetchCourseCategory();
      context.read<NewCourseViewModel>().fetchCourseType();
      await context
          .read<MarketPlaceLearningHubViewModel>()
          .getAllLearningHubData(context, isCommunityLearningHub: false);
      Loaders.circularHideLoader(context);
      await navigationService.navigateTo(RouteList.learningHubMasterView);
    } else if (title == 'Clients') {
      navigationService.navigateTo(RouteList.clientScreen);
    } else if (title == 'Supplies') {
      await context.read<SuppliesViewModel>().getSuppliers(context);
      await context.read<SuppliesViewModel>().getSuppliesCart(context);
      navigationService.navigateTo(RouteList.suppliesMarketPlace);
    }
  }
}
