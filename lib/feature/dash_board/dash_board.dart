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
            unselectedLabelStyle: TextStyles.regular2(),
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
                  icon: SvgPicture.asset(ImageConst.cart,
                      color: AppColors.bottomNavUnSelectedColor),
                  activeIcon: SvgPicture.asset(ImageConst.cart,
                      color: AppColors.primaryColor),
                  label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
      /*  BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: AppColors.buttomBarColor,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(context, ImageConst.home, "Home", 0),
              _buildNavItem(context, ImageConst.feed, "Feeds", 1),
              _buildNavItemWithBadge(context, ImageConst.chat, "Messages", 2,
                  showBadge: true),
              const SizedBox(width: 40),
              _buildNavItem(context, ImageConst.cart, "Cart", 3),
              _buildProfileItem(context, 4),
            ],
          ),
        ),
      ),*/
    );
  }

  /* Widget _buildNavItem(
      BuildContext context, String icon, String label, int index) {
    final navProvider = Provider.of<DashBoardViewModel>(context);
    final isActive = navProvider.currentIndex == index;

    return GestureDetector(
      onTap: index >= 0 ? () => navProvider.setIndex(index) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon,
              color: isActive
                  ? AppColors.black
                  : AppColors.bottomBarSelectIconColor),
          // Icon(icon, color: isActive ? Colors.black : Colors.grey),
          Text(label,
              style: TextStyle(
                  color: isActive
                      ? AppColors.black
                      : AppColors.bottomBarSelectIconColor,
                  fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildNavItemWithBadge(
      BuildContext context, String icon, String label, int index,
      {bool showBadge = false}) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: _buildNavItem(context, icon, label, index),
        ),
        if (showBadge)
          const Positioned(
            right: 12,
            top: 2,
            child: CircleAvatar(radius: 5, backgroundColor: Colors.orange),
          ),
      ],
    );
  }

  Widget _buildProfileItem(BuildContext context, int index) {
    final navProvider = Provider.of<DashBoardViewModel>(context);
    final isActive = navProvider.currentIndex == index;
    return GestureDetector(
      onTap: index >= 0 ? () => navProvider.setIndex(index) : null,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.orange,
                child: Icon(Icons.person, size: 18, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text("Profile",
                  style: TextStyle(
                      color: isActive
                          ? AppColors.black
                          : AppColors.bottomBarSelectIconColor,
                      fontSize: 12)),
            ],
          ),
          const Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(radius: 5, backgroundColor: Colors.black),
          ),
        ],
      ),
    );
  }*/
}
