import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/data/local_storage.dart';
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

    return FutureBuilder<String>(
      future: LocalStorage.getStringVal(LocalStorageConst.type),
      builder: (context, snapshot) {
        final type = snapshot.data ?? '';

        return Scaffold(
            body: dashBoardVM.pages.isEmpty 
                ? const Center(child: CircularProgressIndicator())
                : dashBoardVM.pages[currentIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                // height: 80,
                child: BottomNavigationBar(
                  backgroundColor: AppColors.backgroundColor,
                  currentIndex: dashBoardVM.pages.isEmpty ? 0 : dashBoardVM.currentIndex,
                  onTap: dashBoardVM.pages.isEmpty ? null : (index) => dashBoardVM.setIndex(index, context),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: AppColors.primaryColor,
                  unselectedItemColor: AppColors.bottomNavUnSelectedColor,
                  selectedLabelStyle: TextStyles.regular1(fontSize: 10),
                  unselectedLabelStyle: TextStyles.regular1(fontSize: 10),
                  items: [
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(ImageConst.home,
                            height: 24, width: 24,
                            color: AppColors.bottomNavUnSelectedColor),
                        activeIcon: SvgPicture.asset(ImageConst.home,
                            height: 24, width: 24,
                            color: AppColors.primaryColor),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Image.asset(ImageConst.feed,
                            height: 24, width: 24,
                            color: AppColors.bottomNavUnSelectedColor),
                        activeIcon: Image.asset(ImageConst.feed,
                            height: 24, width: 24,
                            color: AppColors.primaryColor),
                        label: 'Feeds'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(ImageConst.jobSeek,
                            height: 24, width: 24,
                            color: AppColors.bottomNavUnSelectedColor),
                        activeIcon: SvgPicture.asset(ImageConst.jobSeek,
                            height: 24, width: 24,
                            color: AppColors.primaryColor),
                        label: 'Job Seek'),
                        if (type == "PROFESSIONAL" || type =="SUPPLIER")
                      BottomNavigationBarItem(
                          icon: Icon(Icons.group, size: 24), label: 'Community'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(ImageConst.catalogue,
                            height: 24, width: 24,
                            color: AppColors.bottomNavUnSelectedColor),
                        activeIcon: SvgPicture.asset(ImageConst.catalogue,
                            height: 24, width: 24,
                            color: AppColors.primaryColor),
                        label: 'Catalogue'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person, size: 24), label: 'Profile'),
                    
                  ],
                ),
              ),
            ));
      },
    );
  }
}
