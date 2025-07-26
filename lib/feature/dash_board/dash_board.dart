import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoardVM = Provider.of<DashBoardViewModel>(context);
    final currentIndex = dashBoardVM.currentIndex;

    return Scaffold(
        body: dashBoardVM.pages[currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            // height: 80,
            child: BottomNavigationBar(
              backgroundColor: AppColors.backgroundColor,
              currentIndex: dashBoardVM.currentIndex,
              onTap: (index) => dashBoardVM.setIndex(index, context),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.bottomNavUnSelectedColor,
              selectedLabelStyle: TextStyles.medium1(),
              unselectedLabelStyle: TextStyles.regular1(),
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(ImageConst.home,
                        color: AppColors.bottomNavUnSelectedColor),
                    activeIcon: SvgPicture.asset(ImageConst.home,
                        color: AppColors.primaryColor),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Image.asset(ImageConst.feed,
                        color: AppColors.bottomNavUnSelectedColor),
                    activeIcon: Image.asset(ImageConst.feed,
                        color: AppColors.primaryColor),
                    label: 'Feeds'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(ImageConst.jobSeek,
                        color: AppColors.bottomNavUnSelectedColor),
                    activeIcon: SvgPicture.asset(ImageConst.jobSeek,
                        color: AppColors.primaryColor),
                    label: 'Job Seek'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(ImageConst.catalogue,
                        height: 25,
                        width: 25,
                        color: AppColors.bottomNavUnSelectedColor),
                    activeIcon: SvgPicture.asset(ImageConst.catalogue,
                        height: 25, width: 25, color: AppColors.primaryColor),
                    label: 'Catalogue'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile')
              ],
            ),
          ),
        ));
  }
}
