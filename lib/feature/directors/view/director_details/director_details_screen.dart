import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_basic_info.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/home/view/user_data.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DirectorDetailsScreen extends StatelessWidget {
  const DirectorDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final directionalVM = Provider.of<DirectoryViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              navigationService.navigateTo(RouteList.directorQuickLinks);
            },
            backgroundColor: AppColors.primaryColor,
            child:
                SvgPicture.asset(ImageConst.filter, color: AppColors.whiteColor)),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: UserData(
                imageUrl: directionalVM.directorDetails?.logo?.url ??
                    directionalVM.directorDetails?.profileImage?.url ??
                    '',
                userName: directionalVM.directorDetails?.professionType,
                followerCount:
                    '${directionalVM.getFollowersData?.whoIsFollowingAggregate?.aggregate?.count ?? 0}',
                followingCount:
                    '${directionalVM.getFollowersData?.toWhomeIAmFollowingAggregate?.aggregate?.count ?? 0}',
                bannerImg: directionalVM.directorDetails?.bannerImage?.url ?? '',
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DirectorBasicInfo(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
