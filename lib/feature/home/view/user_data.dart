import 'package:di360_flutter/common/banner/list_banner.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/services/banner_services.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserData extends StatelessWidget with BaseContextHelpers {
  final String? imageUrl;
  final String? userName;
  final String? followerCount;
  final String? followingCount;
  final String? bannerImg;
  final String type;
  final String? gender;
  const UserData(
      {super.key,
      this.imageUrl,
      this.userName,
      this.followerCount,
      this.followingCount,
      this.bannerImg,
      this.type = '',
      this.gender});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Column(children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          BannerServices.instance.listBanner?.isEmpty ?? false
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(ImageConst.homePageBanner,
                          width: getSize(context).width),
                    ),
                  ),
                )
              : ListBanner(),
        ],
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            Divider(color: AppColors.dividerColor),
            addVertical(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CachedNetworkImageWidget(
                            imageUrl:
                                imageUrl ?? homeViewModel.profilePic ?? '',
                            fit: BoxFit.cover,
                            errorWidget: type == UserRole.professional.value
                                ? gender?.toLowerCase() == 'male'
                                    ? Image.asset(ImageConst.man)
                                    : Image.asset(ImageConst.woman)
                                : Image.asset(ImageConst.man))),
                  ),
                ),
                addHorizontal(12),
                Text(userName ?? homeViewModel.userName ?? '',
                    style: TextStyles.clashMedium(
                        fontSize: 20, color: AppColors.black)),
              ],
            ),
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
