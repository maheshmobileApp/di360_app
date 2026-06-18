import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/services/notification_service.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();

    final dashBoardVM = Provider.of<DashBoardViewModel>(context, listen: false);
    dashBoardVM.checkForUpdate(context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await dashBoardVM.getUserType();
    });

    if (dashBoardVM.isInitialized) {
      _handlePendingNotification();
    } else {
      dashBoardVM.addListener(_onDashBoardInitialized);
    }
  }

  void _onDashBoardInitialized() {
    final dashBoardVM = Provider.of<DashBoardViewModel>(context, listen: false);
    if (dashBoardVM.isInitialized) {
      dashBoardVM.removeListener(_onDashBoardInitialized);
      _handlePendingNotification();
    }
  }

  void _handlePendingNotification() {
    // Use Future.delayed to ensure the full widget tree + navigator is settled
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) NotificationService.handlePendingInitialMessage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashBoardVM = Provider.of<DashBoardViewModel>(context);

    if (!dashBoardVM.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentIndex = dashBoardVM.currentIndex;
    final pages = dashBoardVM.pages;
    final type = dashBoardVM.userType;

    return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.backgroundColor,
            currentIndex: currentIndex,
            onTap: (index) => dashBoardVM.setIndex(index, context),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.bottomNavUnSelectedColor,
            selectedLabelStyle: TextStyles.regular1(fontSize: 10),
            unselectedLabelStyle: TextStyles.regular1(fontSize: 10),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(ImageConst.home,
                      height: 24,
                      width: 24,
                      color: AppColors.bottomNavUnSelectedColor),
                  activeIcon: SvgPicture.asset(ImageConst.home,
                      height: 24, width: 24, color: AppColors.primaryColor),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Image.asset(ImageConst.feed,
                      height: 24,
                      width: 24,
                      color: AppColors.bottomNavUnSelectedColor),
                  activeIcon: Image.asset(ImageConst.feed,
                      height: 24, width: 24, color: AppColors.primaryColor),
                  label: 'Feeds'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(ImageConst.jobSeek,
                      height: 24,
                      width: 24,
                      color: AppColors.bottomNavUnSelectedColor),
                  activeIcon: SvgPicture.asset(ImageConst.jobSeek,
                      height: 24, width: 24, color: AppColors.primaryColor),
                  label: 'Job Seek'),
              if (type == UserRole.professional.value ||
                  type == UserRole.supplier.value ||
                  type == UserRole.admin.value)
                BottomNavigationBarItem(
                    icon: Icon(Icons.group, size: 24), label: 'Community'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(ImageConst.catalogue,
                      height: 24,
                      width: 24,
                      color: AppColors.bottomNavUnSelectedColor),
                  activeIcon: SvgPicture.asset(ImageConst.catalogue,
                      height: 24, width: 24, color: AppColors.primaryColor),
                  label: 'Catalogue'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 24),
                  label: type == UserRole.admin.value ? 'Clients' : 'Profile')
            ],
          ),
        ));
  }
}
