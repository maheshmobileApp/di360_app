import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/view/my_director/user_details_widget.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_basic_info.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DirectorDetailsScreen extends StatefulWidget {
  const DirectorDetailsScreen({super.key});

  @override
  State<DirectorDetailsScreen> createState() => _DirectorDetailsScreenState();
}

class _DirectorDetailsScreenState extends State<DirectorDetailsScreen> {
  String? type;

  @override
  void initState() {
    super.initState();
    _loadUserType();
  }

  _loadUserType() async {
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    setState(() {
      type = userType;
    });
  }

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
            child: SvgPicture.asset(ImageConst.filter,
                color: AppColors.whiteColor)),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: UserDetailsWidget(
                    imageUrl: directionalVM.directorDetails?.logo?.url ??
                        directionalVM.directorDetails?.profileImage?.url ??
                        '',
                    userName: directionalVM.directorDetails?.professionType,
                    followerCount:
                        '${directionalVM.getFollowersData?.whoIsFollowingAggregate?.aggregate?.count ?? 0}',
                    followingCount:
                        '${directionalVM.getFollowersData?.toWhomeIAmFollowingAggregate?.aggregate?.count ?? 0}',
                    bannerImg:
                        directionalVM.directorDetails?.bannerImage?.url ?? '',
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
            /*(directionalVM.directorDetails?.professionType ==
                        "Dental  Community" &&
                    type == "PROFESSIONAL")*/
            /*(directionalVM.directorDetails?.professionType ==
                        "Dental  Community" &&
                    type == "PROFESSIONAL")*/
            (type == "PROFESSIONAL" || type == "SUPPLIER")
                ? Positioned(
                    top: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () async {

                      
                        (type == "PROFESSIONAL")
                            ? ((directionalVM.communityStatusString ==
                                    "Join Community")
                                ? navigationService
                                    .navigateTo(RouteList.joinCommunityView)
                                : null)
                            : ((directionalVM.partnershipStatusString ==
                                    "Partnership Request")? navigationService.navigateTo(
                                RouteList.partnershipCommunityRequestView):null);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              type == "PROFESSIONAL"
                                  ? directionalVM.communityStatusString
                                  : directionalVM.partnershipStatusString,
                              style: TextStyles.semiBold(
                                  color: AppColors.whiteColor, fontSize: 14)),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
