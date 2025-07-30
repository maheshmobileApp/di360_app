import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_basic_info.dart';
import 'package:di360_flutter/feature/home/view/user_data.dart';
import 'package:flutter/material.dart';

class DirectorDetailsScreen extends StatelessWidget {
  const DirectorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          UserData(),
          Expanded(
              child: Container(
            color: AppColors.buttomBarColor,
            child: Card(
              margin: EdgeInsets.all(12),
              color: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [DirectorBasicInfo()],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
