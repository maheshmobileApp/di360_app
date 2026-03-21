import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/view/my_director/director_details_view.dart';
import 'package:di360_flutter/feature/add_directors/view/my_director/user_details_widget.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfessionalDirectorScreen extends StatelessWidget {
  const ProfessionalDirectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final directionalVM = Provider.of<DirectoryViewModel>(context);
    final professVM = Provider.of<ProfessionalAddDirectorVm>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      floatingActionButton: FloatingActionButton.extended(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: () {
            professVM.updateCurrentStep();
            navigationService.navigateTo(RouteList.professionAddDirectorView);
          },
          backgroundColor: AppColors.primaryColor,
          label: Text('Update directory',
              style: TextStyles.medium2(color: AppColors.whiteColor))),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: UserDetailsWidget(
                    imageUrl: addDirectorVM.getBasicInfoData.first.profileImage?.url ?? '',
                    userName: addDirectorVM.getBasicInfoData.first.professionType,
                    followerCount:
                        '${directionalVM.getFollowersData?.whoIsFollowingAggregate?.aggregate?.count ?? 0}',
                    followingCount:
                        '${directionalVM.getFollowersData?.toWhomeIAmFollowingAggregate?.aggregate?.count ?? 0}',
                    bannerImg:
                        addDirectorVM.getBasicInfoData.first.bannerImage?.url ?? '',
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DirectorDetailsView()),
                ),
              ],
            ),
            Positioned(
                left: 20,
                top: 20,
                child: GestureDetector(
                    onTap: () async{
                      final type = await LocalStorage.getStringVal(
                          LocalStorageConst.type);
                      context.read<DashBoardViewModel>().setIndex(
                          type == UserRole.practice.value ? 4 : 5, context);
                      navigationService
                          .pushNamedAndRemoveUntil(RouteList.dashBoard);
                    },
                    child: CircleAvatar(
                        radius: 25, child: Icon(Icons.arrow_back))))
          ],
        ),
      ),
    );
  }
}
