import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/team_members/view_model/team_members_view_model.dart';
import 'package:di360_flutter/feature/team_members/widgets/team_member_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TeamMembersListingView extends StatefulWidget {
  const TeamMembersListingView({super.key});

  @override
  State<TeamMembersListingView> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<TeamMembersListingView>
    with BaseContextHelpers {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadData(loadMore: true);
    }
  }

  Future<void> _loadData({bool loadMore = false}) async {
    final viewModel = Provider.of<TeamMembersViewModel>(context, listen: false);
    if (!loadMore) {
      Loaders.circularShowLoader(context);
    }
    await viewModel.getTeamMembers(loadMore: loadMore);
    if (!loadMore) {
      Loaders.circularHideLoader(context);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TeamMembersViewModel>(context);
    var floatingActionButton = FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        viewModel.clearFields();
        viewModel.setEditMode(false);
        navigationService.navigateTo(RouteList.createTeamMemberView);
      },
      child: SvgPicture.asset(ImageConst.addFeed),
    );

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBarWidget(
          title: 'Team Members',
          searchWidget: false
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: viewModel.teamMembersData?.clients?.isEmpty ?? true
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No access requests found",
                              style: TextStyles.medium2(color: AppColors.black),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: (viewModel.teamMembersData?.clients?.length ?? 0) + (viewModel.hasMoreTeamMembers ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == viewModel.teamMembersData?.clients?.length) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          final teamMemberData =
                              viewModel.teamMembersData?.clients?[index];
                          return TeamMemberCard(
                            id: teamMemberData?.id ?? "",
                            userName: teamMemberData?.businessName ?? "",
                            email: teamMemberData?.email ?? "",
                            status: teamMemberData?.status ?? "",
                            onMenuAction: (action, id) async {
                              switch (action) {
                                case "Edit":
                                  viewModel.setEditMode(true);
                                  viewModel.setEditedId(id);

                                  await viewModel.getSubSupplier(context, id);
                                  navigationService.navigateTo(
                                    RouteList.createTeamMemberView,
                                  );

                                  break;
                                case "Delete":
                                  showAlertMessage(context,
                                      'Are you sure you want to remove this team member?',
                                      onBack: () {
                                    navigationService.goBack();
                                    viewModel.deleteTeamMember(context, id);
                                  });

                                  break;
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: floatingActionButton);
  }
}
