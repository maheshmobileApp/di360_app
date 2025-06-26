import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
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
      margin: EdgeInsets.only(top: 20, left: 43, right: 43),
      padding: EdgeInsets.all(10),
      height: 60,
      width: 290,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(116, 130, 148, 0.3),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _tabButton(
            title: "Popular Jobs",
            width: 110,
            isActive: tabViewModel.selectedTabIndex == 0,
            onTap: () => tabViewModel.setSelectedIndex(0),
          ),
          SizedBox(width: 10),
          _tabButton(
            title: "Talents",
            width: 100,
            isActive: tabViewModel.selectedTabIndex == 1,
            onTap: () => tabViewModel.setSelectedIndex(1),
          ),
        ],
      ),
    );
  }

  Widget _tabButton({
    required String title,
    required double width,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(isActive ? 100 : 30),
      child: Container(
        height: 40,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(isActive ? 100 : 30),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 1,
            letterSpacing: 0,
            color: isActive
                ? Color.fromRGBO(255, 255, 255, 1)
                : Color.fromRGBO(116, 130, 148, 1),
          ),
        ),
      ),
    );
  }
}
