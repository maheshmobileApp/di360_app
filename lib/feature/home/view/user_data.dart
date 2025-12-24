import 'package:di360_flutter/common/banner/list_banner.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/services/banner_services.dart';

class UserData extends StatelessWidget with BaseContextHelpers {
  final String? imageUrl;
  final String? userName;
  final String? followerCount;
  final String? followingCount;
  final String? bannerImg;
  const UserData(
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
          BannerServices.instance.listBanner?.isEmpty ?? false
              ? SvgPicture.asset(ImageConst.homeBG,
                  width: getSize(context).width)
              : ListBanner(),
          Positioned(
              right: 1,
              left: 1,
              bottom: -40,
              child: CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                radius: 52,
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 50,
                  child: ClipOval(
                    child: SizedBox(
                      height: 100,
                      width: 100,
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
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            addVertical(50),
            Divider(color: AppColors.dividerColor),
            addVertical(6),
            Text(userName ?? homeViewModel.userName ?? '',
                style: TextStyles.clashMedium(
                    fontSize: 20, color: AppColors.black)),
            addVertical(6),
            Divider(color: AppColors.dividerColor),
            addVertical(6),
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
            addVertical(6),
            Divider(color: AppColors.dividerColor),
            addVertical(20)
          ]))
    ]);
  }

  Widget followerData(String title, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(title, style: TextStyles.regular2(color: AppColors.black)),
          addHorizontal(14),
          Text(val,
              style: TextStyles.medium3(
                  fontSize: 20, color: AppColors.primaryColor))
        ],
      ),
    );
  }
}
