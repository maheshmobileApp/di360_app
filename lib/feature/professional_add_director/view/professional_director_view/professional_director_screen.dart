import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/add_directors/view/my_director/director_details_view.dart';
import 'package:di360_flutter/feature/add_directors/view/my_director/user_details_widget.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            professVM.updateCurrentStep();
            navigationService.navigateTo(RouteList.professionAddDirectorView);
          },
          backgroundColor: AppColors.primaryColor,
          child: SvgPicture.asset(ImageConst.addFeed,
              color: AppColors.whiteColor)),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: UserDetailsWidget(
                imageUrl: addDirectorVM.getBasicInfoData.first.logo?.url ?? '',
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
                child: DirectorDetailsView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
