import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_basic_info.dart';
import 'package:di360_flutter/feature/home/view/user_data.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';

class DirectorDetailsScreen extends StatelessWidget {
  const DirectorDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigationService.navigateTo(RouteList.directorQuickLinks);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.filter_list, color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: UserData(
              imageUrl: "https://your-image.jpg",
              userName: "Dr. John Doe",
              followerCount: "1024",
              followingCount: "326",
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DirectorBasicInfo(),
            ),
          ),
        ],
      ),
    );
  }
}
