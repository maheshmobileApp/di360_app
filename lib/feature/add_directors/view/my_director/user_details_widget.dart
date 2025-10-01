import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserDetailsWidget extends StatelessWidget with BaseContextHelpers {
  final String? imageUrl;
  final String? userName;
  final String? followerCount;
  final String? followingCount;
  final String? bannerImg;
  const UserDetailsWidget(
      {super.key,
      this.imageUrl,
      this.userName,
      this.followerCount,
      this.followingCount,
      this.bannerImg});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Column(children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          bannerImg == null || bannerImg?.isEmpty == true
              ? SizedBox(
                  height: 220,
                  child: Center(
                      child: Text('No Banner Image',
                          style: TextStyles.medium4(color: AppColors.black))))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImageWidget(
                      imageUrl: bannerImg ?? '',
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.fill)),
          Positioned(
              left: 20,
              top: 20,
              child: GestureDetector(
                  onTap: () => navigationService.goBack(),
                  child:
                      CircleAvatar(radius: 25, child: Icon(Icons.arrow_back)))),
          Positioned(
              right: 1,
              left: 1,
              bottom: -46,
              child: CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                radius: 63,
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 60,
                  child: ClipOval(
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: CachedNetworkImageWidget(
                          imageUrl: imageUrl ?? homeViewModel.profilePic ?? '',
                          fit: BoxFit.fill,
                          errorWidget: Image.asset(ImageConst.prfImg)),
                    ),
                  ),
                ),
              ))
        ],
      ),
      addVertical(20),
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
              child: Text(userName ?? homeViewModel.userName ?? '',
                  style: TextStyles.clashMedium(
                      fontSize: 20, color: AppColors.black)),
            ),
            Divider(color: AppColors.dividerColor),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              followerData(
                  'Followers',
                  followerCount ??
                      '${homeViewModel.getFollowersData?.whoIsFollowingAggregate?.aggregate?.count ?? 0}'),
              followerData(
                  'Following',
                  followingCount ??
                      '${homeViewModel.getFollowersData?.toWhomeIAmFollowingAggregate?.aggregate?.count ?? 0}')
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
