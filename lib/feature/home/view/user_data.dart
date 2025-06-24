import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserData extends StatelessWidget with BaseContextHelpers {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Column(children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(ImageConst.homeBG),
          Positioned(
              left: 20,
              top: 44,
              child: CircleAvatar(
                  radius: 25, child: SvgPicture.asset(ImageConst.logo))),
          Positioned(
              right: 20,
              top: 44,
              child: CircleAvatar(
                backgroundColor: AppColors.menuBGColor,
                radius: 25,
                child: Image.asset(ImageConst.menu, color: AppColors.whiteColor),
              )),
          Positioned(
              right: 1,
              left: 1,
              bottom: -26,
              child: CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                radius: 63,
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 60,
                  child: ClipOval(
                    child: Transform.scale(
                      scale: 1,
                      child: CachedNetworkImageWidget(
                        imageUrl: homeViewModel.profilePic ?? '',
                        errorWidget: Image.asset(ImageConst.prfImg)),
                    ),
                  ),
                ),
              ))
        ],
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Welcome Back!',
                  style: TextStyles.dmsansLight(
                      color: AppColors.black, fontSize: 12)),
              Row(
                children: [
                  SvgPicture.asset(ImageConst.notification),
                  addHorizontal(28),
                  SvgPicture.asset(ImageConst.search)
                ],
              )
            ]),
            addVertical(12),
            Divider(color: AppColors.dividerColor),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(homeViewModel.userName ?? '',
                  style: TextStyles.clashMedium(
                      fontSize: 20, color: AppColors.black)),
            ),
            Divider(color: AppColors.dividerColor),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              followerData('Followers', '${homeViewModel.getFollowersData?.whoIsFollowingAggregate?.aggregate?.count ?? 0}'),
              followerData('Following', '${homeViewModel.getFollowersData?.toWhomeIAmFollowingAggregate?.aggregate?.count ?? 0}')
            ]),
            Divider(color: AppColors.dividerColor)
          ]))
    ]);
  }

  Widget followerData(String title, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(title, style: TextStyles.regular1(color: AppColors.black)),
          addHorizontal(14),
          Text(
            val,
            style:
                TextStyles.medium3(fontSize: 20, color: AppColors.primaryColor),
          )
        ],
      ),
    );
  }
}
