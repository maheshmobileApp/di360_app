import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabSwitch extends StatelessWidget {
  const TabSwitch({
    super.key,
    this.onTabChange,
  });
  final Function(int index)? onTabChange;

  @override
  Widget build(BuildContext context) {
    final tabViewModel = Provider.of<JobSeekViewModel>(context);
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow( 
                color: Colors.black.withOpacity(.6),
                blurRadius: 12.0,
                spreadRadius: 6.0,
                offset: Offset(
                  0,
                  10,
                ))
          ],
        ),
        child: Row(
          children: [
            _tabButton(
              context,
              "Popular Jobs",
              0,
              tabViewModel.selectedTabIndex == 0,
              () => tabViewModel.setSelectedIndex(0),
            ),
            _tabButton(
              context,
              "Talents",
              1,
              tabViewModel.selectedTabIndex == 1,
              () => tabViewModel.setSelectedIndex(1),
            ),
          ],
        ));
  }

  Widget _tabButton(BuildContext context, String title, int index,
      bool isActive, void Function()? onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(title,
              style: TextStyles.medium2(
                color: isActive
                    ? AppColors.whiteColor
                    : AppColors.bottomNavUnSelectedColor,
              )),
        ),
      ),
    );
  }
}
