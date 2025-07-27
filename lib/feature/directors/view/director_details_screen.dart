import 'package:di360_flutter/common/constants/app_colors.dart';
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
          Expanded(child: Container(
            color: AppColors.buttomBarColor
          ))
        ],
      ),
    );
  }
}