import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/community/widgets/join_request_card.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinRequestView extends StatefulWidget {
  @override
  State<JoinRequestView> createState() => _JoinRequestViewState();
}



class _JoinRequestViewState extends State<JoinRequestView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<CommunityViewModel>(context, listen: false);
      viewModel.changeStatus("All", context);
      viewModel.getJoinRequest(context);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final viewModel = Provider.of<CommunityViewModel>(context, listen: false);
      viewModel.getJoinRequest(context,loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);
    final joinRequests = viewModel.communityMembers?.communityMembers;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title: "Join Requests",
        searchWidget: false,
      ),
      body: Column(
        children: [
          statusWidget(viewModel),
          (joinRequests?.length != 0 && joinRequests != null)?
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(10),
              itemCount: joinRequests.length + (viewModel.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == joinRequests.length) {
                  return Center(child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(color: AppColors.primaryColor,),
                  ));
                }
                return JoinRequestCard(
                    firstName: joinRequests[index].firstName ?? "",
                    lastName: joinRequests[index].lastName ?? "",
                    email: joinRequests[index].email ?? "",
                    phone: joinRequests[index].phone ?? "",
                    status: joinRequests[index].status ?? "",
                    membership: joinRequests[index].membershipNumber ?? "",
                    onMenuAction: (action) async {
                      switch (action) {
                        case "Approve":
                          await viewModel.approveJoinRequest(
                              joinRequests[index].id ?? "", "APPROVED",context);

                          break;
                        case "Reject":
                          await viewModel.approveJoinRequest(
                              joinRequests[index].id ?? "", "REJECTED",context);

                          break;
                      }
                    });
              },
            ),
          ) : Expanded(
            child: Center(
              child: Text(
                "No Join Requests",
                style: TextStyles.medium3(color: AppColors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox statusWidget(CommunityViewModel communityVM) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: communityVM.statuses.length,
        itemBuilder: (context, index) {
          String status = communityVM.statuses[index];
          bool isSelected = communityVM.selectedStatus == status;
          return GestureDetector(
            onTap: () {
              communityVM.changeStatus(status, context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.primaryColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Row(
                children: [
                  Text(
                    status,
                    style: TextStyles.regular2(
                      color:
                          isSelected ? AppColors.whiteColor : AppColors.black,
                    ),
                  ),
                  SizedBox(width: 6),
                  /*Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "",
                      style: TextStyles.regular2(
                        color:
                            isSelected ? AppColors.black : AppColors.whiteColor,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
